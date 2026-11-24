import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sga_bojanini/core/network/api_error_mapper.dart';
import 'package:sga_bojanini/core/network/api_exception.dart';

import '../../helpers/fixtures.dart';

DioException _bad(int status, Object? body) => DioException(
  requestOptions: RequestOptions(),
  type: DioExceptionType.badResponse,
  response: Response(
    requestOptions: RequestOptions(),
    statusCode: status,
    data: body,
  ),
);

void main() {
  group('ApiErrorMapper.fromDio', () {
    test('401 → UnauthenticatedException con el mensaje del servidor', () {
      final error = ApiErrorMapper.fromDio(
        _bad(401, {'success': false, 'message': 'Credenciales inválidas.'}),
      );
      expect(error, isA<UnauthenticatedException>());
      expect(error.message, 'Credenciales inválidas.');
    });

    test('403 de cuenta desactivada se distingue de un 403 de permiso', () {
      final disabled = ApiErrorMapper.fromDio(
        _bad(403, {
          'message':
              'Tu cuenta ha sido desactivada. Contacta al administrador.',
        }),
      );
      final denied = ApiErrorMapper.fromDio(
        _bad(403, {'message': "No tienes el permiso 'stock.ver'."}),
      );
      expect((disabled as ForbiddenException).accountDisabled, isTrue);
      expect((denied as ForbiddenException).accountDisabled, isFalse);
    });

    test('409 conserva error_code', () {
      final error = ApiErrorMapper.fromDio(
        _bad(409, {'message': 'Lote vencido', 'error_code': 'EXPIRED_STOCK'}),
      );
      expect(error, isA<BusinessRuleException>());
      expect((error as BusinessRuleException).errorCode, 'EXPIRED_STOCK');
    });

    test('422 mapea errors por campo, incluidas claves con índices', () {
      final error =
          ApiErrorMapper.fromDio(
                _bad(422, fixture('auth/error_validation.json')),
              )
              as ValidationException;
      expect(error.firstErrorFor('email'), 'El correo no es válido.');
      expect(
        error.firstErrorFor('items.0.quantity_base'),
        'Debe ser mayor que 0.',
      );
      expect(error.firstErrorFor('otro'), isNull);
    });

    test('404, 429 y 5xx', () {
      expect(ApiErrorMapper.fromDio(_bad(404, {})), isA<NotFoundException>());
      expect(
        ApiErrorMapper.fromDio(_bad(429, {})),
        isA<RateLimitedException>(),
      );
      final server = ApiErrorMapper.fromDio(_bad(500, 'boom'));
      expect(server, isA<ServerException>());
      expect(server.statusCode, 500);
    });

    test('timeouts y fallos de conexión son NetworkException', () {
      for (final (type, kind) in [
        (DioExceptionType.connectionTimeout, NetworkFailureKind.timeout),
        (DioExceptionType.receiveTimeout, NetworkFailureKind.timeout),
        (DioExceptionType.connectionError, NetworkFailureKind.noConnection),
      ]) {
        final error = ApiErrorMapper.fromDio(
          DioException(requestOptions: RequestOptions(), type: type),
        );
        expect(error, isA<NetworkException>());
        expect((error as NetworkException).kind, kind);
      }
    });

    test('un ApiException ya mapeado se conserva', () {
      const original = BusinessRuleException('x');
      final error = ApiErrorMapper.fromDio(
        DioException(requestOptions: RequestOptions(), error: original),
      );
      expect(error, same(original));
    });
  });

  test('apiCall relanza DioException como ApiException', () {
    expect(
      () => apiCall<void>(() => throw _bad(409, {'message': 'x'})),
      throwsA(isA<BusinessRuleException>()),
    );
  });
}

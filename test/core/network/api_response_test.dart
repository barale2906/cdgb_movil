import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sga_bojanini/core/network/api_exception.dart';
import 'package:sga_bojanini/core/network/api_response.dart';

Response<dynamic> _response(Object? body, {int status = 200}) => Response(
  requestOptions: RequestOptions(),
  data: body,
  statusCode: status,
);

void main() {
  group('ApiResponse', () {
    test('object devuelve data', () {
      final response = _response({
        'success': true,
        'message': 'OK',
        'data': {'id': 1},
      });
      expect(ApiResponse.object(response), {'id': 1});
      expect(ApiResponse.message(response), 'OK');
    });

    test('list parsea cada elemento', () {
      final response = _response({
        'success': true,
        'data': [
          {'id': 1},
          {'id': 2},
        ],
      });
      final ids = ApiResponse.list(response, (json) => json['id'] as int);
      expect(ids, [1, 2]);
    });

    test('page incluye meta y hasMore', () {
      final response = _response({
        'success': true,
        'data': [
          {'id': 1},
        ],
        'meta': {
          'current_page': 1,
          'last_page': 3,
          'per_page': 25,
          'total': 60,
        },
      });
      final page = ApiResponse.page(response, (json) => json['id'] as int);
      expect(page.items, [1]);
      expect(page.meta.total, 60);
      expect(page.meta.hasMore, isTrue);
    });

    test('page sin meta es una respuesta inesperada', () {
      final response = _response({'success': true, 'data': <dynamic>[]});
      expect(
        () => ApiResponse.page(response, (json) => json),
        throwsA(isA<ServerException>()),
      );
    });

    test('un cuerpo que no es el envoltorio lanza ServerException', () {
      expect(
        () => ApiResponse.object(_response('<html>')),
        throwsA(isA<ServerException>()),
      );
      expect(
        () => ApiResponse.object(_response({'success': true, 'data': 5})),
        throwsA(isA<ServerException>()),
      );
    });

    test('success=false se rechaza', () {
      expect(
        () => ApiResponse.object(_response({'success': false})),
        throwsA(isA<ServerException>()),
      );
    });
  });
}

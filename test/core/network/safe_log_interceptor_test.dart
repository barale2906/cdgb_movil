import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sga_bojanini/core/network/interceptors.dart';

import '../../helpers/fake_http_adapter.dart';

void main() {
  late List<String> lines;
  late Dio dio;
  late FakeHttpAdapter adapter;

  setUp(() {
    lines = [];
    adapter = FakeHttpAdapter();
    dio = Dio(BaseOptions(baseUrl: 'http://localhost'))
      ..httpClientAdapter = adapter
      ..interceptors.add(SafeLogInterceptor(sink: lines.add));
  });

  test('registra solo método, ruta y estado', () async {
    adapter.on('GET', '/patients', body: {'success': true});

    await dio.get<dynamic>('/patients');

    expect(lines, ['GET /patients → 200']);
  });

  test('nunca registra parámetros, cabeceras ni cuerpo (privacidad)', () async {
    adapter.on('POST', '/auth/login', body: {'success': true});

    await dio.post<dynamic>(
      '/auth/login',
      data: {'email': 'a@example.com', 'password': 'secreto-123'},
      queryParameters: {'documento': '1020304050'},
      options: Options(headers: {'Authorization': 'Bearer token-secreto'}),
    );

    final text = lines.join(' ');
    for (final secret in [
      'secreto-123',
      'a@example.com',
      '1020304050',
      'token-secreto',
      'Bearer',
      'documento',
    ]) {
      expect(text, isNot(contains(secret)), reason: secret);
    }
    expect(lines.single, 'POST /auth/login → 200');
  });

  test('un error del servidor se registra con su estado', () async {
    adapter.on('GET', '/boom', status: 500, body: {'success': false});

    await expectLater(dio.get<dynamic>('/boom'), throwsA(isA<DioException>()));

    expect(lines, ['GET /boom → 500']);
  });

  test('sin respuesta (red caída) se registra sin estado', () async {
    adapter.onError('GET', '/offline', DioExceptionType.connectionTimeout);

    await expectLater(
      dio.get<dynamic>('/offline'),
      throwsA(isA<DioException>()),
    );

    expect(lines, ['GET /offline → sin respuesta']);
  });
}

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';

typedef RouteHandler = ResponseBody Function(RequestOptions options);

/// Servidor falso para Dio: respuestas programadas por `MÉTODO /ruta`.
/// Sin red real (CLAUDE.md §7).
class FakeHttpAdapter implements HttpClientAdapter {
  final Map<String, List<RouteHandler>> _routes = {};
  final Map<String, int> _callCounts = {};
  final List<RequestOptions> requests = [];

  /// Registra una respuesta JSON. Las respuestas de una misma ruta se
  /// entregan en orden de registro; la última se repite.
  void on(String method, String path, {int status = 200, Object? body}) {
    _add(method, path, (_) => _json(status, body));
  }

  /// Respuesta binaria (PDF, imágenes).
  void onBytes(
    String method,
    String path,
    List<int> bytes, {
    int status = 200,
  }) {
    _add(method, path, (_) => ResponseBody.fromBytes(bytes, status));
  }

  void onError(String method, String path, DioExceptionType type) {
    _add(method, path, (options) {
      throw DioException(requestOptions: options, type: type);
    });
  }

  void onSocketFailure(String method, String path) {
    _add(method, path, (options) {
      throw DioException(
        requestOptions: options,
        type: DioExceptionType.connectionError,
        error: const SocketException('sin red'),
      );
    });
  }

  Iterable<RequestOptions> callsTo(String method, String path) =>
      requests.where((r) => r.method == method && r.path == path);

  void _add(String method, String path, RouteHandler handler) {
    _routes.putIfAbsent('$method $path', () => []).add(handler);
  }

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requests.add(options);
    final key = '${options.method} ${options.path}';
    final handlers = _routes[key];
    if (handlers == null) {
      throw StateError('Ruta sin programar: $key');
    }
    final call = _callCounts.update(key, (n) => n + 1, ifAbsent: () => 0);
    return handlers[call < handlers.length ? call : handlers.length - 1](
      options,
    );
  }

  @override
  void close({bool force = false}) {}

  static ResponseBody _json(int status, Object? body) =>
      ResponseBody.fromString(
        jsonEncode(body),
        status,
        headers: {
          Headers.contentTypeHeader: [Headers.jsonContentType],
        },
      );
}

/// Envoltorio de éxito de la API.
Map<String, dynamic> envelope(Object? data, {String message = 'OK'}) => {
  'success': true,
  'message': message,
  'data': data,
};

Map<String, dynamic> errorBody(String message, {Map<String, dynamic>? extra}) =>
    {'success': false, 'message': message, ...?extra};

/// Respuesta paginada de la API (`data` + `meta`).
Map<String, dynamic> pagedBody(
  List<dynamic> data, {
  int page = 1,
  int lastPage = 1,
}) => {
  'success': true,
  'message': 'OK',
  'data': data,
  'meta': {
    'current_page': page,
    'last_page': lastPage,
    'per_page': 25,
    'total': data.length,
  },
};

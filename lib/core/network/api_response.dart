import 'package:dio/dio.dart';
import 'package:sga_bojanini/core/network/api_exception.dart';

typedef Json = Map<String, dynamic>;

/// Metadatos de paginación (`meta`) del envoltorio de la API.
class PageMeta {
  const PageMeta({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
  });

  factory PageMeta.fromJson(Json json) => PageMeta(
    currentPage: json['current_page'] as int,
    lastPage: json['last_page'] as int,
    perPage: json['per_page'] as int,
    total: json['total'] as int,
  );

  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;

  bool get hasMore => currentPage < lastPage;
}

class PagedList<T> {
  const PagedList({required this.items, required this.meta});

  final List<T> items;
  final PageMeta meta;
}

/// Parseo único del envoltorio `{success, message, data, meta?, errors?}`.
abstract final class ApiResponse {
  /// Máximo de elementos por página que acepta la API.
  static const maxPageSize = 100;
  static const defaultPageSize = 25;

  /// `message` del envoltorio, o vacío si no viene.
  static String message(Response<dynamic> response) {
    final body = _body(response);
    return body['message'] as String? ?? '';
  }

  /// `data` cuando es un objeto.
  static Json object(Response<dynamic> response) {
    final data = _body(response)['data'];
    if (data is Json) return data;
    throw _malformed(response);
  }

  /// `data` cuando es una lista de objetos (paginada o no).
  static List<T> list<T>(Response<dynamic> response, T Function(Json) parse) {
    final data = _body(response)['data'];
    if (data is! List<dynamic>) throw _malformed(response);
    return [for (final item in data) parse(_asJson(item, response))];
  }

  /// Lista paginada: exige `meta`.
  static PagedList<T> page<T>(
    Response<dynamic> response,
    T Function(Json) parse,
  ) {
    final meta = _body(response)['meta'];
    if (meta is! Json) throw _malformed(response);
    return PagedList(
      items: list(response, parse),
      meta: PageMeta.fromJson(meta),
    );
  }

  static Json _body(Response<dynamic> response) {
    final body = response.data;
    if (body is Json && body['success'] != false) return body;
    throw _malformed(response);
  }

  static Json _asJson(Object? item, Response<dynamic> response) {
    if (item is Json) return item;
    throw _malformed(response);
  }

  static ServerException _malformed(Response<dynamic> response) =>
      ServerException(
        'Respuesta inesperada del servidor.',
        statusCode: response.statusCode,
      );
}

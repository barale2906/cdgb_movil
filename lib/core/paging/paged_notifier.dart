import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/network/api_exception.dart';
import 'package:sga_bojanini/core/network/api_response.dart';

/// Estado de una lista paginada (`page`/`per_page` + `meta`).
@immutable
class PagedState<T> {
  const PagedState({
    this.items = const [],
    this.nextPage = 1,
    this.hasMore = true,
    this.isLoading = false,
    this.error,
  });

  final List<T> items;
  final int nextPage;
  final bool hasMore;

  /// Hay una petición en curso (primera página, recarga o "cargar más").
  final bool isLoading;
  final ApiException? error;

  bool get isInitialLoading => isLoading && items.isEmpty;
  bool get isInitialError => error != null && items.isEmpty;
  bool get isEmpty => !isLoading && error == null && items.isEmpty;
}

/// Base de las listas con scroll infinito. Cada subclase define
/// [fetchPage]; los errores quedan en el estado para mostrar el reintento
/// manual (nunca se reintenta solo).
abstract class PagedNotifier<T> extends Notifier<PagedState<T>> {
  /// Tamaño de página pedido al servidor (máx. 100).
  static const int pageSize = ApiResponse.defaultPageSize;

  @protected
  Future<PagedList<T>> fetchPage(int page);

  @override
  PagedState<T> build() {
    unawaited(Future.microtask(refresh));
    return const PagedState(isLoading: true);
  }

  /// Vuelve a la primera página conservando lo mostrado mientras carga.
  Future<void> refresh() => _load(page: 1, replace: true);

  Future<void> loadMore() async {
    if (state.isLoading || !state.hasMore || state.error != null) return;
    await _load(page: state.nextPage, replace: false);
  }

  /// Reintento manual tras un error (primera página o "cargar más").
  Future<void> retry() => state.items.isEmpty
      ? refresh()
      : _load(page: state.nextPage, replace: false);

  Future<void> _load({required int page, required bool replace}) async {
    if (!ref.mounted) return;
    state = PagedState(
      items: state.items,
      nextPage: state.nextPage,
      hasMore: state.hasMore,
      isLoading: true,
    );
    try {
      final result = await fetchPage(page);
      if (!ref.mounted) return;
      state = PagedState(
        items: replace ? result.items : [...state.items, ...result.items],
        nextPage: page + 1,
        hasMore: result.meta.hasMore,
      );
    } on ApiException catch (error) {
      if (!ref.mounted) return;
      state = PagedState(
        items: replace ? const [] : state.items,
        nextPage: state.nextPage,
        hasMore: state.hasMore,
        error: error,
      );
    }
  }
}

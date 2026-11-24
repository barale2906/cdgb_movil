import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sga_bojanini/core/network/api_exception.dart';
import 'package:sga_bojanini/core/network/api_response.dart';
import 'package:sga_bojanini/core/network/no_auto_retry.dart';
import 'package:sga_bojanini/core/paging/paged_notifier.dart';

class _Notifier extends PagedNotifier<int> {
  static final calls = <int>[];
  static Object? failOnPage;

  @override
  Future<PagedList<int>> fetchPage(int page) async {
    calls.add(page);
    if (failOnPage == page) {
      failOnPage = null;
      throw const NetworkException(NetworkFailureKind.noConnection);
    }
    return PagedList(
      items: List.generate(3, (i) => (page - 1) * 3 + i),
      meta: PageMeta(currentPage: page, lastPage: 3, perPage: 3, total: 9),
    );
  }
}

final NotifierProvider<_Notifier, PagedState<int>> _provider =
    NotifierProvider.autoDispose<_Notifier, PagedState<int>>(
      _Notifier.new,
    );

Future<void> _settle() => Future<void>.delayed(Duration.zero);

void main() {
  late ProviderContainer container;

  setUp(() {
    _Notifier.calls.clear();
    _Notifier.failOnPage = null;
    container = ProviderContainer(retry: noAutoRetry);
    addTearDown(container.dispose);
  });

  test('carga la primera página al leerlo', () async {
    final sub = container.listen(_provider, (_, _) {});
    expect(container.read(_provider).isInitialLoading, isTrue);
    await _settle();

    final state = container.read(_provider);
    expect(state.items, [0, 1, 2]);
    expect(state.hasMore, isTrue);
    expect(state.nextPage, 2);
    sub.close();
  });

  test('loadMore agrega páginas y para en la última', () async {
    final sub = container.listen(_provider, (_, _) {});
    await _settle();
    final notifier = container.read(_provider.notifier);

    await notifier.loadMore();
    await notifier.loadMore();
    await notifier.loadMore();

    expect(container.read(_provider).items, hasLength(9));
    expect(container.read(_provider).hasMore, isFalse);
    expect(_Notifier.calls, [1, 2, 3], reason: 'no pide una cuarta página');
    sub.close();
  });

  test('no lanza dos cargas a la vez', () async {
    final sub = container.listen(_provider, (_, _) {});
    await _settle();
    final notifier = container.read(_provider.notifier);

    await Future.wait([notifier.loadMore(), notifier.loadMore()]);

    expect(_Notifier.calls, [1, 2]);
    sub.close();
  });

  test(
    'error en la primera página: estado de error y reintento manual',
    () async {
      _Notifier.failOnPage = 1;
      final sub = container.listen(_provider, (_, _) {});
      await _settle();

      expect(container.read(_provider).isInitialError, isTrue);
      expect(_Notifier.calls, [1], reason: 'sin reintento automático');

      await container.read(_provider.notifier).retry();
      expect(container.read(_provider).items, [0, 1, 2]);
      sub.close();
    },
  );

  test(
    'error al cargar más: conserva lo ya cargado y reintenta esa página',
    () async {
      final sub = container.listen(_provider, (_, _) {});
      await _settle();
      _Notifier.failOnPage = 2;
      final notifier = container.read(_provider.notifier);

      await notifier.loadMore();
      expect(container.read(_provider).items, [0, 1, 2]);
      expect(container.read(_provider).error, isNotNull);

      await notifier.retry();
      expect(container.read(_provider).items, hasLength(6));
      expect(container.read(_provider).error, isNull);
      sub.close();
    },
  );

  test('refresh vuelve a la primera página', () async {
    final sub = container.listen(_provider, (_, _) {});
    await _settle();
    final notifier = container.read(_provider.notifier);
    await notifier.loadMore();

    await notifier.refresh();

    expect(container.read(_provider).items, [0, 1, 2]);
    expect(container.read(_provider).nextPage, 2);
    sub.close();
  });
}

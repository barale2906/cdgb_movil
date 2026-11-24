import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sga_bojanini/core/network/no_auto_retry.dart';

void main() {
  test('un provider que falla no se reintenta solo', () async {
    var calls = 0;
    final failing = FutureProvider<int>((ref) {
      calls++;
      throw Exception('sin red');
    });
    final container = ProviderContainer(retry: noAutoRetry);
    addTearDown(container.dispose);

    final subscription = container.listen(failing, (_, _) {});
    await Future<void>.delayed(const Duration(milliseconds: 600));

    expect(calls, 1);
    expect(container.read(failing).hasError, isTrue);
    subscription.close();
  });

  test(
    'sin noAutoRetry, Riverpod sí reintenta (por eso se desactiva)',
    () async {
      var calls = 0;
      final failing = FutureProvider<int>((ref) {
        calls++;
        throw Exception('sin red');
      });
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final subscription = container.listen(failing, (_, _) {});
      await Future<void>.delayed(const Duration(milliseconds: 600));

      expect(calls, greaterThan(1));
      subscription.close();
    },
  );
}

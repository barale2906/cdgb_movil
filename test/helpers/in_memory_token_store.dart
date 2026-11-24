import 'package:sga_bojanini/core/auth/token_store.dart';

class InMemoryTokenStore implements TokenStore {
  InMemoryTokenStore([this.session]);

  StoredSession? session;

  @override
  Future<StoredSession?> read() async => session;

  @override
  Future<void> write(StoredSession session) async => this.session = session;

  @override
  Future<void> clear() async => session = null;
}

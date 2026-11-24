import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Origen del estado de red; se sustituye en pruebas.
abstract interface class ConnectivitySource {
  Future<bool> isOnline();
  Stream<bool> get onChanged;
}

class PlatformConnectivitySource implements ConnectivitySource {
  PlatformConnectivitySource([Connectivity? connectivity])
    : _connectivity = connectivity ?? Connectivity();

  final Connectivity _connectivity;

  @override
  Future<bool> isOnline() async =>
      _hasLink(await _connectivity.checkConnectivity());

  @override
  Stream<bool> get onChanged =>
      _connectivity.onConnectivityChanged.map(_hasLink);

  static bool _hasLink(List<ConnectivityResult> results) =>
      results.any((result) => result != ConnectivityResult.none);
}

final connectivitySourceProvider = Provider<ConnectivitySource>(
  (ref) => PlatformConnectivitySource(),
);

/// `true` si el equipo tiene algún enlace de red. No garantiza que el
/// servidor sea alcanzable (VPN apagada, etc.): eso lo reportan las
/// peticiones como `NetworkException`.
final isOnlineProvider = StreamProvider<bool>((ref) async* {
  final source = ref.watch(connectivitySourceProvider);
  yield await source.isOnline();
  yield* source.onChanged;
});

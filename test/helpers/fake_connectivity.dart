import 'dart:async';

import 'package:sga_bojanini/core/connectivity/connectivity_provider.dart';

class FakeConnectivitySource implements ConnectivitySource {
  FakeConnectivitySource({this.online = true});

  bool online;
  final _controller = StreamController<bool>.broadcast();

  @override
  Future<bool> isOnline() async => online;

  @override
  Stream<bool> get onChanged => _controller.stream;

  void emit({required bool online}) {
    this.online = online;
    _controller.add(online);
  }

  Future<void> dispose() => _controller.close();
}

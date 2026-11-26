import 'dart:async';

import 'package:sga_bojanini/core/push/push_gateway.dart';

/// Servicio de push falso: se emiten avisos a mano y se configura qué
/// responde (permiso, token, fallos).
class FakePushGateway implements PushGateway {
  FakePushGateway({this.tokenValue = 'fcm-token-1', this.initial});

  String? tokenValue;
  bool available = true;
  bool permissionGranted = true;
  bool throwOnToken = false;
  PushMessage? initial;
  int permissionRequests = 0;

  final _refresh = StreamController<String>.broadcast();
  final _foreground = StreamController<PushMessage>.broadcast();
  final _opened = StreamController<PushMessage>.broadcast();

  void emitRefresh(String token) => _refresh.add(token);
  void emitForeground(String? type) => _foreground.add(PushMessage(type: type));
  void emitOpened(String? type) => _opened.add(PushMessage(type: type));

  @override
  Future<bool> initialize() async => available;

  @override
  Future<bool> requestPermission() async {
    permissionRequests++;
    return permissionGranted;
  }

  @override
  Future<String?> token() async {
    if (throwOnToken) throw StateError('sin token');
    return tokenValue;
  }

  @override
  Stream<String> get onTokenRefresh => _refresh.stream;

  @override
  Stream<PushMessage> get onForegroundMessage => _foreground.stream;

  @override
  Stream<PushMessage> get onOpened => _opened.stream;

  @override
  Future<PushMessage?> initialMessage() async => initial;
}

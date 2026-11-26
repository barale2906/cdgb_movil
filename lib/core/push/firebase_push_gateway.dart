import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:sga_bojanini/core/push/push_gateway.dart';

/// FCM sobre `firebase_messaging`. Delgado a propósito: la lógica vive en
/// `DeviceRegistrar` y en la navegación, que se prueban con un gateway falso.
class FirebasePushGateway implements PushGateway {
  FirebasePushGateway._();

  /// Inicia Firebase y devuelve el gateway; `null` si el APK se compiló sin
  /// `google-services.json` (la app funciona igual, sin push).
  static Future<FirebasePushGateway?> tryCreate() async {
    try {
      // Al reiniciar la app (cambio de servidor) Firebase ya está iniciado.
      if (Firebase.apps.isEmpty) await Firebase.initializeApp();
    } on Object {
      return null;
    }
    return FirebasePushGateway._();
  }

  FirebaseMessaging get _messaging => FirebaseMessaging.instance;

  @override
  Future<bool> initialize() async => true;

  @override
  Future<bool> requestPermission() async {
    final settings = await _messaging.requestPermission();
    return settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional;
  }

  @override
  Future<String?> token() => _messaging.getToken();

  @override
  Stream<String> get onTokenRefresh => _messaging.onTokenRefresh;

  @override
  Stream<PushMessage> get onForegroundMessage =>
      FirebaseMessaging.onMessage.map(_toMessage);

  @override
  Stream<PushMessage> get onOpened =>
      FirebaseMessaging.onMessageOpenedApp.map(_toMessage);

  @override
  Future<PushMessage?> initialMessage() async {
    final message = await _messaging.getInitialMessage();
    return message == null ? null : _toMessage(message);
  }

  static PushMessage _toMessage(RemoteMessage message) =>
      PushMessage(type: message.data['type'] as String?);
}

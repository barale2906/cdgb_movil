import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Aviso push recibido. Solo trae el tipo: el contenido es genérico y el
/// detalle se carga dentro de la app (Ley 1581).
@immutable
class PushMessage {
  const PushMessage({this.type});

  final String? type;
}

/// Puerta hacia el servicio de push del dispositivo (FCM en Android).
///
/// Se separa de Firebase para poder usar la app sin él (compilaciones sin
/// `google-services.json`, pruebas) y para no acoplar `core/` al SDK.
abstract class PushGateway {
  /// Prepara el servicio; `false` si no está disponible en este equipo.
  Future<bool> initialize();

  /// Pide el permiso de notificaciones (Android 13+); `true` si se concedió.
  Future<bool> requestPermission();

  Future<String?> token();

  /// Token nuevo asignado por el servicio mientras la app vive.
  Stream<String> get onTokenRefresh;

  /// Aviso recibido con la app abierta (no se muestra solo).
  Stream<PushMessage> get onForegroundMessage;

  /// La persona tocó un aviso con la app en segundo plano.
  Stream<PushMessage> get onOpened;

  /// Aviso que abrió la app desde cerrada, si lo hubo.
  Future<PushMessage?> initialMessage();
}

/// Sin push: lo usa la app cuando Firebase no está configurado.
class DisabledPushGateway implements PushGateway {
  const DisabledPushGateway();

  @override
  Future<bool> initialize() async => false;

  @override
  Future<bool> requestPermission() async => false;

  @override
  Future<String?> token() async => null;

  @override
  Stream<String> get onTokenRefresh => const Stream.empty();

  @override
  Stream<PushMessage> get onForegroundMessage => const Stream.empty();

  @override
  Stream<PushMessage> get onOpened => const Stream.empty();

  @override
  Future<PushMessage?> initialMessage() async => null;
}

final pushGatewayProvider = Provider<PushGateway>(
  (ref) => const DisabledPushGateway(),
);

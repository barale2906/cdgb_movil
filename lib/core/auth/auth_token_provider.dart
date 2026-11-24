import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Token Bearer en memoria; lo escribe solo el `SessionController`.
/// Existe aparte para que el interceptor de Dio lo lea sin depender del
/// estado de la sesión (evita un ciclo de providers).
class AuthTokenNotifier extends Notifier<String?> {
  @override
  String? build() => null;

  // Un Notifier no puede exponer `state` como setter con otro nombre.
  // ignore: use_setters_to_change_properties
  void replace(String? token) {
    state = token;
  }
}

final authTokenProvider = NotifierProvider<AuthTokenNotifier, String?>(
  AuthTokenNotifier.new,
);

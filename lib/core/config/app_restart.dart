import 'package:flutter/widgets.dart';

/// Permite reiniciar la app por dentro (nuevo `ProviderScope`), p. ej. al
/// cambiar de servidor en dev. La provee `RestartableApp`.
class AppRestart extends InheritedWidget {
  const AppRestart({required this.restart, required super.child, super.key});

  final Future<void> Function() restart;

  static AppRestart? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AppRestart>();

  @override
  bool updateShouldNotify(AppRestart oldWidget) => false;
}

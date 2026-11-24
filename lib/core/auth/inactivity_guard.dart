import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/auth/session_controller.dart';
import 'package:sga_bojanini/core/auth/session_state.dart';
import 'package:sga_bojanini/core/clock/clock.dart';
import 'package:sga_bojanini/core/config/app_environment_provider.dart';

/// Bloquea la sesión tras N minutos sin interacción o en segundo plano y
/// cierra el turno al superar el máximo de horas (teléfonos compartidos,
/// `docs/plan/02` §4.7).
class InactivityGuard extends ConsumerStatefulWidget {
  const InactivityGuard({required this.child, super.key});

  final Widget child;

  @override
  ConsumerState<InactivityGuard> createState() => _InactivityGuardState();
}

class _InactivityGuardState extends ConsumerState<InactivityGuard>
    with WidgetsBindingObserver {
  Timer? _timer;
  DateTime? _backgroundedAt;

  Duration get _timeout => Duration(
    minutes: ref.read(appEnvironmentProvider).inactivityLockMinutes,
  );

  SessionController get _session =>
      ref.read(sessionControllerProvider.notifier);

  bool get _isActive {
    final session = ref.read(sessionControllerProvider);
    return session is SessionAuthenticated && !session.locked;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _restartTimer();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _timer?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
      case AppLifecycleState.hidden:
        _onBackground();
      case AppLifecycleState.resumed:
        _onResume();
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
        break;
    }
  }

  void _onBackground() {
    if (!_isActive) return;
    _backgroundedAt ??= ref.read(clockProvider)();
    _timer?.cancel();
    unawaited(_session.recordBackground());
  }

  void _onResume() {
    final since = _backgroundedAt;
    _backgroundedAt = null;
    unawaited(_session.enforceShiftLimit());
    if (!_isActive) return;
    final away = since == null
        ? Duration.zero
        : ref.read(clockProvider)().difference(since);
    if (away >= _timeout) {
      _session.lock();
    } else {
      _restartTimer();
    }
  }

  void _restartTimer() {
    _timer?.cancel();
    if (!_isActive) return;
    _timer = Timer(_timeout, () {
      if (_isActive) _session.lock();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Al desbloquear o iniciar sesión se reinicia el conteo.
    ref.listen(sessionControllerProvider, (_, _) => _restartTimer());

    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: (_) => _restartTimer(),
      onPointerUp: (_) => _restartTimer(),
      child: widget.child,
    );
  }
}

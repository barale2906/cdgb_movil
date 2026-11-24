import 'dart:async';

/// Retrasa una acción hasta que pasa [delay] sin nuevas llamadas
/// (búsquedas mientras se escribe).
class Debouncer {
  Debouncer(this.delay);

  final Duration delay;
  Timer? _timer;

  void run(void Function() action) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }

  void dispose() => _timer?.cancel();
}

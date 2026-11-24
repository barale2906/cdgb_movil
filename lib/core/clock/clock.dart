import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef Clock = DateTime Function();

/// Reloj inyectable: las pruebas lo sustituyen para ser deterministas.
final clockProvider = Provider<Clock>((ref) => DateTime.now);

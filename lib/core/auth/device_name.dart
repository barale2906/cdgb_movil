import 'package:flutter_riverpod/flutter_riverpod.dart';

/// `device_name` del token: permite al web identificar y revocar tokens por
/// teléfono. Se calcula al arrancar (`main.dart`) y se sobrescribe aquí.
final deviceNameProvider = Provider<String>((ref) => 'app-movil');

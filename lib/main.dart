import 'package:flutter/material.dart';
import 'package:sga_bojanini/bootstrap.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(RestartableApp(initial: await AppBootstrap.load()));
}

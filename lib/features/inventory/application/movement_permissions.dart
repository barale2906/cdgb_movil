import 'package:flutter/material.dart';

/// Tipos de movimiento que la app puede registrar y su permiso.
enum MovementKind {
  entry('movimientos.entrada', Icons.south_west, '/inventory/new/entry'),
  exit('movimientos.salida', Icons.north_east, '/inventory/new/exit'),
  transfer(
    'movimientos.transferir',
    Icons.swap_horiz,
    '/inventory/new/transfer',
  ),
  adjustment('movimientos.ajuste', Icons.tune, '/inventory/new/adjustment'),
  returnStock('movimientos.devolucion', Icons.undo, '/inventory/new/return'),
  writeOff('movimientos.baja', Icons.event_busy, '/inventory/new/write-off'),
  loss('movimientos.baja', Icons.report_problem_outlined, '/inventory/new/loss')
  ;

  const MovementKind(this.permission, this.icon, this.path);

  final String permission;
  final IconData icon;
  final String path;

  /// Todos los permisos de movimiento (para saber si hay algo que ofrecer).
  static final Set<String> permissions = {
    for (final kind in values) kind.permission,
  };
}

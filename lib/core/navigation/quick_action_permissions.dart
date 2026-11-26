/// Permisos de las acciones rápidas que se ofrecen en Inicio y en su sección:
/// un único lugar para que ambas pantallas decidan igual.
abstract final class QuickActionPermissions {
  /// Registrar una venta: crear el registro y buscar el servicio
  /// (`medical-services/search`).
  static const sale = [
    'registros_procedimientos.crear',
    'servicios_medicos.ver',
  ];

  /// Crear una orden de servicio: crearla y buscar el procedimiento.
  static const newOrder = ['ordenes_servicio.crear', 'servicios_medicos.ver'];
}

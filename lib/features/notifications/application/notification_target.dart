import 'package:sga_bojanini/features/notifications/data/app_notification.dart';

/// Pantalla a la que lleva una notificación (por su `type`); `null` si no
/// tiene destino propio y solo se muestra el mensaje. Las rutas son de
/// secciones ya validadas por permisos en el router.
String? notificationTargetPath(AppNotification notification) =>
    notificationTargetForType(notification.type);

/// Igual que [notificationTargetPath], a partir del `type` de la notificación
/// o del aviso push.
String? notificationTargetForType(String? type) => switch (type) {
  'condition_out_of_range' ||
  'condition_trend_alert' ||
  'sensor_calibration_alert' => '/monitoring',
  'stock_below_reorder' ||
  'batch_expiring_soon' ||
  'batch_expired' => '/inventory',
  'report_ready' || 'report_failed' => '/reports/exports',
  'purchase_order_pending_approval' ||
  'purchase_order_approved' ||
  'purchase_order_rejected' ||
  'reorder_suggestions' => '/purchasing',
  'service_order_discount_pending' ||
  'service_order_discount_approved' => '/service-orders',
  'asset_maintenance_alert' || 'asset_expiration_alert' => '/assets',
  _ => null,
};

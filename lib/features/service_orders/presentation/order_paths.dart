/// Rutas de la sección de órdenes de servicio (el detalle de una orden vive en
/// `OrderDetailPage.pathFor`).
abstract final class OrderPaths {
  static const newOrder = '/service-orders/new';
  static const patient = '$newOrder/patient';
  static const service = '$newOrder/service';
  static const product = '$newOrder/product';
}

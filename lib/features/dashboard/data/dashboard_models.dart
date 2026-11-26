// El backend usa claves como `expiring_7_days`, que la conversión automática
// a snake_case no produce a partir de `expiring7Days`.
// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sga_bojanini/core/utils/json_converters.dart';

part 'dashboard_models.freezed.dart';
part 'dashboard_models.g.dart';

@freezed
abstract class TopConsumedProduct with _$TopConsumedProduct {
  const factory TopConsumedProduct({
    required int id,
    required String name,
    String? barcode,
    @DoubleConverter() double? totalConsumed,
  }) = _TopConsumedProduct;

  factory TopConsumedProduct.fromJson(Map<String, dynamic> json) =>
      _$TopConsumedProductFromJson(json);
}

/// `GET /dashboard/inventory` (global, el servidor la guarda 5 minutos).
@freezed
abstract class InventoryDashboard with _$InventoryDashboard {
  const factory InventoryDashboard({
    @Default(0) int totalProducts,
    @Default(0) int totalUnits,
    @Default(0) int stockOkCount,
    @Default(0) int stockLowCount,
    @Default(0) int stockCriticalCount,
    @Default(0) int expiringToday,
    @JsonKey(name: 'expiring_7_days') @Default(0) int expiring7Days,
    @JsonKey(name: 'expiring_30_days') @Default(0) int expiring30Days,
    @Default(0) int movementsToday,
    @Default([]) List<TopConsumedProduct> topConsumedProducts,
  }) = _InventoryDashboard;

  factory InventoryDashboard.fromJson(Map<String, dynamic> json) =>
      _$InventoryDashboardFromJson(json);
}

@freezed
abstract class PurchasingDashboard with _$PurchasingDashboard {
  const factory PurchasingDashboard({
    @Default(0) int pendingOrders,
    @Default(0) int approvedOrders,
    @DoubleConverter() double? totalMonth,
  }) = _PurchasingDashboard;

  factory PurchasingDashboard.fromJson(Map<String, dynamic> json) =>
      _$PurchasingDashboardFromJson(json);
}

@freezed
abstract class MonitoringDashboard with _$MonitoringDashboard {
  const factory MonitoringDashboard({
    @Default(0) int activeSensors,
    @Default(0) int alertsToday,
    @Default(0) int readingsToday,
  }) = _MonitoringDashboard;

  factory MonitoringDashboard.fromJson(Map<String, dynamic> json) =>
      _$MonitoringDashboardFromJson(json);
}

@freezed
abstract class ActivityEntry with _$ActivityEntry {
  const factory ActivityEntry({
    @Default('') String action,
    String? auditableType,
    String? createdAt,
    String? userName,
  }) = _ActivityEntry;

  factory ActivityEntry.fromJson(Map<String, dynamic> json) =>
      _$ActivityEntryFromJson(json);
}

@freezed
abstract class DashboardAlert with _$DashboardAlert {
  const factory DashboardAlert({
    required String id,
    @Default('') String title,
    @Default('') String message,
    @Default('info') String severity,
    String? createdAt,
  }) = _DashboardAlert;

  factory DashboardAlert.fromJson(Map<String, dynamic> json) =>
      _$DashboardAlertFromJson(json);
}

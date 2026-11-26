// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TopConsumedProduct _$TopConsumedProductFromJson(Map<String, dynamic> json) =>
    _TopConsumedProduct(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      barcode: json['barcode'] as String?,
      totalConsumed: const DoubleConverter().fromJson(json['total_consumed']),
    );

Map<String, dynamic> _$TopConsumedProductToJson(_TopConsumedProduct instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'barcode': instance.barcode,
      'total_consumed': const DoubleConverter().toJson(instance.totalConsumed),
    };

_InventoryDashboard _$InventoryDashboardFromJson(Map<String, dynamic> json) =>
    _InventoryDashboard(
      totalProducts: (json['total_products'] as num?)?.toInt() ?? 0,
      totalUnits: (json['total_units'] as num?)?.toInt() ?? 0,
      stockOkCount: (json['stock_ok_count'] as num?)?.toInt() ?? 0,
      stockLowCount: (json['stock_low_count'] as num?)?.toInt() ?? 0,
      stockCriticalCount: (json['stock_critical_count'] as num?)?.toInt() ?? 0,
      expiringToday: (json['expiring_today'] as num?)?.toInt() ?? 0,
      expiring7Days: (json['expiring_7_days'] as num?)?.toInt() ?? 0,
      expiring30Days: (json['expiring_30_days'] as num?)?.toInt() ?? 0,
      movementsToday: (json['movements_today'] as num?)?.toInt() ?? 0,
      topConsumedProducts:
          (json['top_consumed_products'] as List<dynamic>?)
              ?.map(
                (e) => TopConsumedProduct.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
    );

Map<String, dynamic> _$InventoryDashboardToJson(_InventoryDashboard instance) =>
    <String, dynamic>{
      'total_products': instance.totalProducts,
      'total_units': instance.totalUnits,
      'stock_ok_count': instance.stockOkCount,
      'stock_low_count': instance.stockLowCount,
      'stock_critical_count': instance.stockCriticalCount,
      'expiring_today': instance.expiringToday,
      'expiring_7_days': instance.expiring7Days,
      'expiring_30_days': instance.expiring30Days,
      'movements_today': instance.movementsToday,
      'top_consumed_products': instance.topConsumedProducts
          .map((e) => e.toJson())
          .toList(),
    };

_PurchasingDashboard _$PurchasingDashboardFromJson(Map<String, dynamic> json) =>
    _PurchasingDashboard(
      pendingOrders: (json['pending_orders'] as num?)?.toInt() ?? 0,
      approvedOrders: (json['approved_orders'] as num?)?.toInt() ?? 0,
      totalMonth: const DoubleConverter().fromJson(json['total_month']),
    );

Map<String, dynamic> _$PurchasingDashboardToJson(
  _PurchasingDashboard instance,
) => <String, dynamic>{
  'pending_orders': instance.pendingOrders,
  'approved_orders': instance.approvedOrders,
  'total_month': const DoubleConverter().toJson(instance.totalMonth),
};

_MonitoringDashboard _$MonitoringDashboardFromJson(Map<String, dynamic> json) =>
    _MonitoringDashboard(
      activeSensors: (json['active_sensors'] as num?)?.toInt() ?? 0,
      alertsToday: (json['alerts_today'] as num?)?.toInt() ?? 0,
      readingsToday: (json['readings_today'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$MonitoringDashboardToJson(
  _MonitoringDashboard instance,
) => <String, dynamic>{
  'active_sensors': instance.activeSensors,
  'alerts_today': instance.alertsToday,
  'readings_today': instance.readingsToday,
};

_ActivityEntry _$ActivityEntryFromJson(Map<String, dynamic> json) =>
    _ActivityEntry(
      action: json['action'] as String? ?? '',
      auditableType: json['auditable_type'] as String?,
      createdAt: json['created_at'] as String?,
      userName: json['user_name'] as String?,
    );

Map<String, dynamic> _$ActivityEntryToJson(_ActivityEntry instance) =>
    <String, dynamic>{
      'action': instance.action,
      'auditable_type': instance.auditableType,
      'created_at': instance.createdAt,
      'user_name': instance.userName,
    };

_DashboardAlert _$DashboardAlertFromJson(Map<String, dynamic> json) =>
    _DashboardAlert(
      id: json['id'] as String,
      title: json['title'] as String? ?? '',
      message: json['message'] as String? ?? '',
      severity: json['severity'] as String? ?? 'info',
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$DashboardAlertToJson(_DashboardAlert instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'message': instance.message,
      'severity': instance.severity,
      'created_at': instance.createdAt,
    };

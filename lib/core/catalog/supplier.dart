import 'package:freezed_annotation/freezed_annotation.dart';

part 'supplier.freezed.dart';
part 'supplier.g.dart';

@freezed
abstract class Supplier with _$Supplier {
  const factory Supplier({
    required int id,
    required String name,
    String? taxId,
    String? contactName,
    String? phone,
    String? email,
    String? address,
    String? notes,
    @Default(true) bool isActive,
    @Default('inventory') String supplierType,
  }) = _Supplier;

  factory Supplier.fromJson(Map<String, dynamic> json) =>
      _$SupplierFromJson(json);
}

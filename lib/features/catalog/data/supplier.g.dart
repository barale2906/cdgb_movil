// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supplier.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Supplier _$SupplierFromJson(Map<String, dynamic> json) => _Supplier(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  taxId: json['tax_id'] as String?,
  contactName: json['contact_name'] as String?,
  phone: json['phone'] as String?,
  email: json['email'] as String?,
  address: json['address'] as String?,
  notes: json['notes'] as String?,
  isActive: json['is_active'] as bool? ?? true,
  supplierType: json['supplier_type'] as String? ?? 'inventory',
);

Map<String, dynamic> _$SupplierToJson(_Supplier instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'tax_id': instance.taxId,
  'contact_name': instance.contactName,
  'phone': instance.phone,
  'email': instance.email,
  'address': instance.address,
  'notes': instance.notes,
  'is_active': instance.isActive,
  'supplier_type': instance.supplierType,
};

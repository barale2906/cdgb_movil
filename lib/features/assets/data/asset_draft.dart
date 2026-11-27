import 'package:flutter/foundation.dart';
import 'package:sga_bojanini/core/utils/colombia_time.dart';
import 'package:sga_bojanini/features/assets/data/asset_enums.dart';

/// Datos del formulario de un activo (`POST /assets` y `PUT /assets/{id}`).
///
/// El código lo genera el servidor y el tipo sale de la categoría. La
/// ubicación, el responsable y el estado solo se envían al crear: después
/// cambian por traslados y por el cambio de estado.
@immutable
class AssetDraft {
  const AssetDraft({
    required this.name,
    required this.categoryId,
    this.placeId,
    this.responsibleId,
    this.status,
    this.description,
    this.brand,
    this.model,
    this.serial,
    this.acquisitionDate,
    this.acquisitionValue,
    this.supplierId,
    this.invoiceNumber,
    this.warrantyUntil,
    this.notes,
    this.comment,
  });

  final String name;
  final int categoryId;
  final int? placeId;
  final int? responsibleId;
  final AssetStatus? status;
  final String? description;
  final String? brand;
  final String? model;
  final String? serial;
  final DateTime? acquisitionDate;
  final double? acquisitionValue;
  final int? supplierId;
  final String? invoiceNumber;
  final DateTime? warrantyUntil;
  final String? notes;
  final String? comment;

  /// Cuerpo de `POST /assets`: solo lo que tiene valor.
  Map<String, Object> toCreateJson() => {
    ..._detail(),
    'place_id': ?placeId,
    'responsible_id': ?responsibleId,
    if (status != null) 'status': status!.value,
    if (_filled(comment)) 'comment': comment!.trim(),
  }..removeWhere((_, value) => value is String && value.isEmpty);

  /// Cuerpo de `PUT /assets/{id}`: un campo vacío se envía como `null` para
  /// poder borrarlo.
  Map<String, Object?> toUpdateJson() => {
    'name': name.trim(),
    'category_id': categoryId,
    'description': _text(description),
    'brand': _text(brand),
    'model': _text(model),
    'serial': _text(serial),
    'acquisition_date': _date(acquisitionDate),
    'acquisition_value': acquisitionValue,
    'supplier_id': supplierId,
    'invoice_number': _text(invoiceNumber),
    'warranty_until': _date(warrantyUntil),
    'notes': _text(notes),
  };

  Map<String, Object> _detail() => {
    'name': name.trim(),
    'category_id': categoryId,
    if (_filled(description)) 'description': description!.trim(),
    if (_filled(brand)) 'brand': brand!.trim(),
    if (_filled(model)) 'model': model!.trim(),
    if (_filled(serial)) 'serial': serial!.trim(),
    if (acquisitionDate != null)
      'acquisition_date': ColombiaTime.formatDate(acquisitionDate!),
    'acquisition_value': ?acquisitionValue,
    'supplier_id': ?supplierId,
    if (_filled(invoiceNumber)) 'invoice_number': invoiceNumber!.trim(),
    if (warrantyUntil != null)
      'warranty_until': ColombiaTime.formatDate(warrantyUntil!),
    if (_filled(notes)) 'notes': notes!.trim(),
  };

  static bool _filled(String? value) => (value ?? '').trim().isNotEmpty;

  static String? _text(String? value) => _filled(value) ? value!.trim() : null;

  static String? _date(DateTime? value) =>
      value == null ? null : ColombiaTime.formatDate(value);
}

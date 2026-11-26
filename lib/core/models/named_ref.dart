import 'package:freezed_annotation/freezed_annotation.dart';

part 'named_ref.freezed.dart';
part 'named_ref.g.dart';

/// Referencia corta (`{id, name}`) a proveedor, almacén o usuario.
@freezed
abstract class NamedRef with _$NamedRef {
  const factory NamedRef({
    required int id,
    required String name,
    String? code,
    String? email,
  }) = _NamedRef;

  factory NamedRef.fromJson(Map<String, dynamic> json) =>
      _$NamedRefFromJson(json);
}

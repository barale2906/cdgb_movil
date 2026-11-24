import 'package:freezed_annotation/freezed_annotation.dart';

/// El backend manda cantidades como número o como texto decimal
/// (`"10.00"`, columnas `decimal` de Eloquent). Siempre se leen como double.
class DoubleConverter implements JsonConverter<double?, Object?> {
  const DoubleConverter();

  @override
  double? fromJson(Object? json) => switch (json) {
    final num value => value.toDouble(),
    final String value => double.tryParse(value),
    _ => null,
  };

  @override
  Object? toJson(double? object) => object;
}

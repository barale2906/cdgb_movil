import 'package:freezed_annotation/freezed_annotation.dart';

part 'menu_item.freezed.dart';
part 'menu_item.g.dart';

/// Nodo de `GET /auth/menu`. `route` es un identificador lógico del web,
/// no una URL; la app lo traduce a sus pantallas (`AppSection`).
@freezed
abstract class MenuItem with _$MenuItem {
  const factory MenuItem({
    required String key,
    required String label,
    String? icon,
    String? route,
    String? permission,
    @ActionsConverter() @Default({}) Map<String, bool> actions,
    @Default([]) List<MenuItem> children,
  }) = _MenuItem;

  factory MenuItem.fromJson(Map<String, dynamic> json) =>
      _$MenuItemFromJson(json);
}

/// PHP serializa un arreglo asociativo vacío como `[]`: se acepta lista
/// (sin acciones) o mapa.
class ActionsConverter implements JsonConverter<Map<String, bool>, Object?> {
  const ActionsConverter();

  @override
  Map<String, bool> fromJson(Object? json) {
    if (json is! Map<String, dynamic>) return const {};
    return {
      for (final entry in json.entries) entry.key: entry.value == true,
    };
  }

  @override
  Object toJson(Map<String, bool> object) => object;
}

extension MenuItemTree on MenuItem {
  /// Este nodo y todos sus descendientes.
  Iterable<MenuItem> get flattened sync* {
    yield this;
    for (final child in children) {
      yield* child.flattened;
    }
  }
}

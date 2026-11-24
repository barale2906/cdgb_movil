// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MenuItem _$MenuItemFromJson(Map<String, dynamic> json) => _MenuItem(
  key: json['key'] as String,
  label: json['label'] as String,
  icon: json['icon'] as String?,
  route: json['route'] as String?,
  permission: json['permission'] as String?,
  actions: json['actions'] == null
      ? const {}
      : const ActionsConverter().fromJson(json['actions']),
  children:
      (json['children'] as List<dynamic>?)
          ?.map((e) => MenuItem.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$MenuItemToJson(_MenuItem instance) => <String, dynamic>{
  'key': instance.key,
  'label': instance.label,
  'icon': instance.icon,
  'route': instance.route,
  'permission': instance.permission,
  'actions': const ActionsConverter().toJson(instance.actions),
  'children': instance.children.map((e) => e.toJson()).toList(),
};

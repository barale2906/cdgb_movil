// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'version_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VersionInfo _$VersionInfoFromJson(Map<String, dynamic> json) => _VersionInfo(
  latest: json['latest'] as String,
  build: (json['build'] as num).toInt(),
  minBuild: (json['min_build'] as num).toInt(),
  url: json['url'] as String,
  sha256: json['sha256'] as String?,
  notes: json['notes'] as String?,
);

Map<String, dynamic> _$VersionInfoToJson(_VersionInfo instance) =>
    <String, dynamic>{
      'latest': instance.latest,
      'build': instance.build,
      'min_build': instance.minBuild,
      'url': instance.url,
      'sha256': instance.sha256,
      'notes': instance.notes,
    };

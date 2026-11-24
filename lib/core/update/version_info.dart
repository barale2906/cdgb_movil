import 'package:freezed_annotation/freezed_annotation.dart';

part 'version_info.freezed.dart';
part 'version_info.g.dart';

/// Contenido de `version.json` (ver `docs/plan/05` §5).
@freezed
abstract class VersionInfo with _$VersionInfo {
  const factory VersionInfo({
    required String latest,
    required int build,
    required int minBuild,
    required String url,
    String? sha256,
    String? notes,
  }) = _VersionInfo;

  factory VersionInfo.fromJson(Map<String, dynamic> json) =>
      _$VersionInfoFromJson(json);
}

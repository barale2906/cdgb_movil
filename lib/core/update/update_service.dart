import 'package:dio/dio.dart';
import 'package:sga_bojanini/core/update/version_info.dart';

enum UpdateStatus {
  /// Al día, desactivado o no se pudo consultar (nunca bloquea por error).
  upToDate,

  /// Hay una versión más nueva; el aviso es descartable.
  available,

  /// La versión instalada ya no es compatible; se bloquea el uso.
  required,
}

class UpdateCheck {
  const UpdateCheck(this.status, [this.info]);

  static const none = UpdateCheck(UpdateStatus.upToDate);

  final UpdateStatus status;
  final VersionInfo? info;
}

/// Compara el build instalado con `version.json`. Falla en silencio: un
/// servidor caído o un archivo mal formado jamás impiden usar la app.
class UpdateService {
  const UpdateService({required this.dio, required this.currentBuild});

  final Dio dio;
  final int currentBuild;

  Future<UpdateCheck> check(Uri? updateUrl) async {
    if (updateUrl == null) return UpdateCheck.none;
    try {
      final response = await dio.getUri<dynamic>(updateUrl);
      final data = response.data;
      if (data is! Map<String, dynamic>) return UpdateCheck.none;
      return evaluate(VersionInfo.fromJson(data));
    } on DioException {
      return UpdateCheck.none;
    } on Object {
      // JSON con campos faltantes o de otro tipo.
      return UpdateCheck.none;
    }
  }

  UpdateCheck evaluate(VersionInfo info) {
    if (currentBuild < info.minBuild) {
      return UpdateCheck(UpdateStatus.required, info);
    }
    if (currentBuild < info.build) {
      return UpdateCheck(UpdateStatus.available, info);
    }
    return UpdateCheck.none;
  }
}

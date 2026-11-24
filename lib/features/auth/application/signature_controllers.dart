import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/auth/my_signature.dart';
import 'package:sga_bojanini/core/utils/submission_notifier.dart';

/// Guarda la firma. Devuelve el resultado (con el PIN la primera vez).
class SaveSignatureController extends SubmissionNotifier {
  Future<SignatureSaveResult?> submit({
    required String currentPassword,
    required String documentType,
    required String documentNumber,
    required String signature,
  }) async {
    final result = await runValue(
      () => ref
          .read(mySignatureRepositoryProvider)
          .save(
            currentPassword: currentPassword,
            documentType: documentType,
            documentNumber: documentNumber,
            signature: signature,
          ),
    );
    if (result != null) ref.invalidate(mySignatureProvider);
    return result;
  }
}

final NotifierProvider<SaveSignatureController, SubmissionState>
saveSignatureControllerProvider =
    NotifierProvider.autoDispose<SaveSignatureController, SubmissionState>(
      SaveSignatureController.new,
    );

class RegeneratePinController extends SubmissionNotifier {
  Future<SignatureSaveResult?> submit(String currentPassword) async {
    final result = await runValue(
      () => ref
          .read(mySignatureRepositoryProvider)
          .regeneratePin(currentPassword),
    );
    if (result != null) ref.invalidate(mySignatureProvider);
    return result;
  }
}

final NotifierProvider<RegeneratePinController, SubmissionState>
regeneratePinControllerProvider =
    NotifierProvider.autoDispose<RegeneratePinController, SubmissionState>(
      RegeneratePinController.new,
    );

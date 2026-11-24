import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/auth/auth_repository.dart';
import 'package:sga_bojanini/core/auth/session_controller.dart';
import 'package:sga_bojanini/core/utils/submission_notifier.dart';

class LoginController extends SubmissionNotifier {
  Future<bool> submit({required String email, required String password}) => run(
    () => ref
        .read(sessionControllerProvider.notifier)
        .login(email: email.trim(), password: password),
  );
}

final NotifierProvider<LoginController, SubmissionState>
loginControllerProvider =
    NotifierProvider.autoDispose<LoginController, SubmissionState>(
      LoginController.new,
    );

class UnlockController extends SubmissionNotifier {
  Future<bool> submit(String password) =>
      run(() => ref.read(sessionControllerProvider.notifier).unlock(password));
}

final NotifierProvider<UnlockController, SubmissionState>
unlockControllerProvider =
    NotifierProvider.autoDispose<UnlockController, SubmissionState>(
      UnlockController.new,
    );

class ChangePasswordController extends SubmissionNotifier {
  Future<bool> submit({
    required String currentPassword,
    required String newPassword,
  }) => run(
    () => ref
        .read(authRepositoryProvider)
        .changePassword(
          currentPassword: currentPassword,
          newPassword: newPassword,
        ),
  );
}

final NotifierProvider<ChangePasswordController, SubmissionState>
changePasswordControllerProvider =
    NotifierProvider.autoDispose<ChangePasswordController, SubmissionState>(
      ChangePasswordController.new,
    );

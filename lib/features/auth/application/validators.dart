import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Validadores de formulario; devuelven el mensaje de error o `null`.
abstract final class Validators {
  static const minPasswordLength = 8;
  static final _email = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  static String? email(AppLocalizations l10n, String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return l10n.validationEmailRequired;
    return _email.hasMatch(text) ? null : l10n.validationEmailInvalid;
  }

  static String? requiredPassword(AppLocalizations l10n, String? value) =>
      (value ?? '').isEmpty ? l10n.validationPasswordRequired : null;

  static String? newPassword(
    AppLocalizations l10n,
    String? value, {
    required String currentPassword,
  }) {
    final text = value ?? '';
    if (text.length < minPasswordLength) {
      return l10n.validationPasswordMinLength(minPasswordLength);
    }
    return text == currentPassword ? l10n.validationPasswordSame : null;
  }

  static String? confirmation(
    AppLocalizations l10n,
    String? value, {
    required String original,
  }) => value == original ? null : l10n.validationPasswordMismatch;
}

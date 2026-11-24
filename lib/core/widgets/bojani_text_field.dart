import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Campo de texto de la app. Con [isPassword] ofrece mostrar/ocultar.
/// [errorText] permite pintar el error de validación 422 del servidor.
class BojaniTextField extends StatefulWidget {
  const BojaniTextField({
    required this.label,
    super.key,
    this.controller,
    this.validator,
    this.errorText,
    this.isPassword = false,
    this.keyboardType,
    this.textInputAction,
    this.autofillHints,
    this.onFieldSubmitted,
    this.enabled = true,
    this.inputFormatters,
    this.autofocus = false,
    this.helperText,
  });

  final String label;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final String? errorText;
  final bool isPassword;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Iterable<String>? autofillHints;
  final ValueChanged<String>? onFieldSubmitted;
  final bool enabled;
  final List<TextInputFormatter>? inputFormatters;
  final bool autofocus;
  final String? helperText;

  @override
  State<BojaniTextField> createState() => _BojaniTextFieldState();
}

class _BojaniTextFieldState extends State<BojaniTextField> {
  bool _obscured = true;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      enabled: widget.enabled,
      autofocus: widget.autofocus,
      obscureText: widget.isPassword && _obscured,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      autofillHints: widget.autofillHints,
      onFieldSubmitted: widget.onFieldSubmitted,
      inputFormatters: widget.inputFormatters,
      // Sin sugerencias ni autocorrección en credenciales.
      enableSuggestions: !widget.isPassword,
      autocorrect: !widget.isPassword,
      decoration: InputDecoration(
        labelText: widget.label,
        helperText: widget.helperText,
        errorText: widget.errorText,
        errorMaxLines: 3,
        suffixIcon: widget.isPassword
            ? IconButton(
                tooltip: _obscured ? l10n.showPassword : l10n.hidePassword,
                constraints: const BoxConstraints(
                  minWidth: AppSizes.minTouchTarget,
                  minHeight: AppSizes.minTouchTarget,
                ),
                icon: Icon(
                  _obscured
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
                onPressed: () => setState(() => _obscured = !_obscured),
              )
            : null,
      ),
    );
  }
}

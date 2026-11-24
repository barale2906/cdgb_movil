import 'package:flutter/material.dart';

/// Paleta de un estado (guía §2.4): fondo suave, chip, borde, icono y texto.
///
/// [text] se usa sobre [background] y [chipText] sobre [chip]; ambos cumplen
/// contraste AA (4,5:1). Donde el valor principal de la guía no llegaba a AA
/// se usa su tono oscuro alternativo (advertencia, información) o un tono de
/// la misma escala (error: #9B2C2C). Ver test/core/theme/app_theme_test.dart.
@immutable
class StatusPalette {
  const StatusPalette({
    required this.background,
    required this.chip,
    required this.border,
    required this.icon,
    required this.text,
    required this.chipText,
  });

  final Color background;
  final Color chip;
  final Color border;
  final Color icon;
  final Color text;
  final Color chipText;

  StatusPalette lerp(StatusPalette other, double t) => StatusPalette(
    background: Color.lerp(background, other.background, t)!,
    chip: Color.lerp(chip, other.chip, t)!,
    border: Color.lerp(border, other.border, t)!,
    icon: Color.lerp(icon, other.icon, t)!,
    text: Color.lerp(text, other.text, t)!,
    chipText: Color.lerp(chipText, other.chipText, t)!,
  );
}

/// Colores de estado como extensión de tema. El rosa de marca NO es un estado.
@immutable
class StatusColors extends ThemeExtension<StatusColors> {
  const StatusColors({
    required this.success,
    required this.error,
    required this.warning,
    required this.info,
    required this.special,
  });

  static const light = StatusColors(
    success: StatusPalette(
      background: Color(0xFFF0FFF4),
      chip: Color(0xFFC6F6D5),
      border: Color(0xFF9AE6B4),
      icon: Color(0xFF38A169),
      text: Color(0xFF276749),
      chipText: Color(0xFF276749),
    ),
    error: StatusPalette(
      background: Color(0xFFFFF5F5),
      chip: Color(0xFFFED7D7),
      border: Color(0xFFFEB2B2),
      icon: Color(0xFFE53E3E),
      text: Color(0xFFC53030),
      chipText: Color(0xFF9B2C2C),
    ),
    warning: StatusPalette(
      background: Color(0xFFFFFAF0),
      chip: Color(0xFFFEEBC8),
      border: Color(0xFFFBD38D),
      icon: Color(0xFFDD6B20),
      text: Color(0xFF7B341E),
      chipText: Color(0xFF7B341E),
    ),
    info: StatusPalette(
      background: Color(0xFFEBF8FF),
      chip: Color(0xFFBEE3F8),
      border: Color(0xFF90CDF4),
      icon: Color(0xFF3182CE),
      text: Color(0xFF2B6CB0),
      chipText: Color(0xFF2C5282),
    ),
    special: StatusPalette(
      background: Color(0xFFFAF5FF),
      chip: Color(0xFFE9D8FD),
      border: Color(0xFFD6BCFA),
      icon: Color(0xFF6B46C1),
      text: Color(0xFF553C9A),
      chipText: Color(0xFF553C9A),
    ),
  );

  final StatusPalette success;
  final StatusPalette error;
  final StatusPalette warning;
  final StatusPalette info;
  final StatusPalette special;

  @override
  StatusColors copyWith({
    StatusPalette? success,
    StatusPalette? error,
    StatusPalette? warning,
    StatusPalette? info,
    StatusPalette? special,
  }) => StatusColors(
    success: success ?? this.success,
    error: error ?? this.error,
    warning: warning ?? this.warning,
    info: info ?? this.info,
    special: special ?? this.special,
  );

  @override
  StatusColors lerp(ThemeExtension<StatusColors>? other, double t) {
    if (other is! StatusColors) return this;
    return StatusColors(
      success: success.lerp(other.success, t),
      error: error.lerp(other.error, t),
      warning: warning.lerp(other.warning, t),
      info: info.lerp(other.info, t),
      special: special.lerp(other.special, t),
    );
  }
}

extension StatusColorsContext on BuildContext {
  StatusColors get statusColors =>
      Theme.of(this).extension<StatusColors>() ?? StatusColors.light;
}

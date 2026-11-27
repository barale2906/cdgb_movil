import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Desplegable de opciones ya cargadas.
class OptionDropdown<T> extends StatelessWidget {
  const OptionDropdown({
    required this.label,
    required this.options,
    required this.value,
    required this.onChanged,
    super.key,
    this.validator,
    this.nullLabel,
  });

  final String label;

  /// Valor → texto. Si se da [nullLabel] se añade la opción "sin elegir".
  final Map<T, String> options;
  final T? value;
  final ValueChanged<T?> onChanged;
  final String? Function(T?)? validator;
  final String? nullLabel;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      key: ValueKey('$label-$value-${options.length}'),
      initialValue: options.containsKey(value) ? value : null,
      isExpanded: true,
      decoration: InputDecoration(labelText: label),
      items: [
        if (nullLabel != null) DropdownMenuItem<T>(child: Text(nullLabel!)),
        for (final entry in options.entries)
          DropdownMenuItem<T>(
            value: entry.key,
            child: Text(entry.value, overflow: TextOverflow.ellipsis),
          ),
      ],
      onChanged: onChanged,
      validator: validator,
    );
  }
}

/// Desplegable alimentado por un `AsyncValue`: muestra carga y error con
/// reintento en lugar del campo.
class AsyncOptionDropdown<T extends Object> extends StatelessWidget {
  const AsyncOptionDropdown({
    required this.label,
    required this.options,
    required this.labelOf,
    required this.value,
    required this.onChanged,
    required this.onRetry,
    super.key,
    this.validator,
    this.nullLabel,
    this.emptyMessage,
  });

  final String label;
  final AsyncValue<List<T>> options;
  final String Function(T) labelOf;
  final T? value;
  final ValueChanged<T?> onChanged;
  final VoidCallback onRetry;
  final String? Function(T?)? validator;
  final String? nullLabel;
  final String? emptyMessage;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return options.when(
      loading: () => InputDecorator(
        decoration: InputDecoration(labelText: label),
        child: const LinearProgressIndicator(),
      ),
      error: (error, _) => InputDecorator(
        decoration: InputDecoration(labelText: label),
        child: Row(
          children: [
            Expanded(child: Text(l10n.errorGeneric)),
            TextButton(onPressed: onRetry, child: Text(l10n.actionRetry)),
          ],
        ),
      ),
      data: (items) {
        if (items.isEmpty && emptyMessage != null) {
          return InputDecorator(
            decoration: InputDecoration(labelText: label),
            child: Text(emptyMessage!),
          );
        }
        return OptionDropdown<T>(
          label: label,
          options: {for (final item in items) item: labelOf(item)},
          value: value,
          onChanged: onChanged,
          validator: validator,
          nullLabel: nullLabel,
        );
      },
    );
  }
}

DateTime _within(DateTime date, DateTime first, DateTime last) {
  if (date.isBefore(first)) return first;
  return date.isAfter(last) ? last : date;
}

/// Selector de fecha (calendario) con formato `DD/MM/AAAA`.
class DateField extends StatelessWidget {
  const DateField({
    required this.label,
    required this.value,
    required this.onChanged,
    super.key,
    this.required = false,
    this.firstDate,
    this.lastDate,
  });

  final String label;
  final DateTime? value;
  final ValueChanged<DateTime?> onChanged;
  final bool required;
  final DateTime? firstDate;
  final DateTime? lastDate;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return FormField<DateTime>(
      initialValue: value,
      key: ValueKey('$label-$value'),
      validator: (_) =>
          required && value == null ? l10n.validationRequired : null,
      builder: (state) => InkWell(
        borderRadius: BorderRadius.circular(AppRadius.control),
        onTap: () async {
          final first = firstDate ?? DateTime(2000);
          final last = lastDate ?? DateTime(2099, 12, 31);
          final picked = await showDatePicker(
            context: context,
            // Un valor guardado fuera del rango (p. ej. una fecha ya vencida)
            // no puede ser la fecha inicial del calendario.
            initialDate: _within(value ?? DateTime.now(), first, last),
            firstDate: first,
            lastDate: last,
            helpText: l10n.pickDate,
          );
          if (picked != null) onChanged(picked);
        },
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: label,
            errorText: state.errorText,
            suffixIcon: value == null
                ? const Icon(Icons.calendar_today_outlined)
                : IconButton(
                    tooltip: l10n.clearField,
                    icon: const Icon(Icons.close),
                    onPressed: () => onChanged(null),
                  ),
          ),
          child: Text(
            value == null ? '' : AppFormat.date(value!.toIso8601String()),
          ),
        ),
      ),
    );
  }
}

/// Campo de texto de formulario con límite de largo y teclado opcionales.
class LabeledTextField extends StatelessWidget {
  const LabeledTextField({
    required this.label,
    required this.controller,
    super.key,
    this.validator,
    this.keyboardType,
    this.maxLines = 1,
    this.maxLength,
    this.textCapitalization = TextCapitalization.none,
  });

  final String label;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final int maxLines;
  final int? maxLength;
  final TextCapitalization textCapitalization;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      maxLines: maxLines,
      textCapitalization: textCapitalization,
      inputFormatters: [
        if (maxLength != null) LengthLimitingTextInputFormatter(maxLength),
      ],
      decoration: InputDecoration(labelText: label),
    );
  }
}

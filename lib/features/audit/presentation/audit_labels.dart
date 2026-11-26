import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sga_bojanini/core/widgets/status_chip.dart';
import 'package:sga_bojanini/features/audit/data/audit_log.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Acciones que registra la bitácora.
abstract final class AuditActions {
  static const created = 'created';
  static const updated = 'updated';
  static const deleted = 'deleted';
  static const access = 'access';
  static const List<String> filterable = [created, updated, deleted, access];
}

String auditActionLabel(AppLocalizations l10n, String action) =>
    switch (action) {
      AuditActions.created => l10n.auditActionCreated,
      AuditActions.updated => l10n.auditActionUpdated,
      AuditActions.deleted => l10n.auditActionDeleted,
      AuditActions.access => l10n.auditActionAccess,
      _ => l10n.auditActionOther,
    };

/// Acción de la bitácora (nunca solo color).
class AuditActionChip extends StatelessWidget {
  const AuditActionChip({required this.action, super.key});

  final String action;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final (kind, icon) = switch (action) {
      AuditActions.created => (StatusKind.success, Icons.add_circle_outline),
      AuditActions.updated => (StatusKind.info, Icons.edit_outlined),
      AuditActions.deleted => (StatusKind.error, Icons.delete_outline),
      AuditActions.access => (StatusKind.special, Icons.login),
      _ => (StatusKind.warning, Icons.help_outline),
    };
    return StatusChip(
      label: auditActionLabel(l10n, action),
      kind: kind,
      icon: icon,
    );
  }
}

/// Nombre legible de la entidad auditada a partir de su clase PHP:
/// `App\...\GenericProductModel` → `Generic Product`.
String auditEntityName(String? type, AppLocalizations l10n) {
  if (type == null || type.isEmpty) return l10n.auditEntitySystem;
  final shortName = type.split(r'\').last.replaceAll(RegExp(r'Model$'), '');
  return shortName.replaceAllMapped(
    RegExp('(?<=[a-z0-9])(?=[A-Z])'),
    (_) => ' ',
  );
}

/// Un cambio de campo: valor anterior y nuevo (alguno puede faltar).
class AuditChange {
  const AuditChange({required this.field, this.before, this.after});

  final String field;
  final String? before;
  final String? after;
}

const _sensitiveWords = [
  'password',
  'contrasena',
  'token',
  'pin',
  'signature',
  'firma',
  'secret',
  'remember',
];

bool _isSensitive(String field) {
  final lower = field.toLowerCase();
  return _sensitiveWords.any(lower.contains);
}

/// Campos que cambiaron, con los valores sensibles ocultos (contraseñas,
/// tokens, PIN y firmas nunca se muestran, CLAUDE.md §9).
List<AuditChange> auditChanges(AuditLog log, AppLocalizations l10n) {
  final before = log.oldValues ?? const {};
  final after = log.newValues ?? const {};
  final fields = {...before.keys, ...after.keys};
  String? show(String field, Map<String, dynamic> values) {
    if (!values.containsKey(field)) return null;
    return _isSensitive(field) ? l10n.auditValueMasked : _format(values[field]);
  }

  return [
    for (final field in fields)
      AuditChange(
        field: field.replaceAll('_', ' '),
        before: show(field, before),
        after: show(field, after),
      ),
  ];
}

String _format(Object? value) {
  if (value == null) return '-';
  if (value is Map<String, dynamic> || value is List<dynamic>) {
    final text = jsonEncode(value);
    return text.length > 160 ? '${text.substring(0, 160)}…' : text;
  }
  return value.toString();
}

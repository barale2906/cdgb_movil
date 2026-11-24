import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/auth/session_controller.dart';

/// Decide por `user.permissions`, nunca por nombre de rol (CLAUDE.md §5).
@immutable
class PermissionService {
  PermissionService(Iterable<String> permissions)
    : _permissions = Set.unmodifiable(permissions);

  static final none = PermissionService(const []);

  final Set<String> _permissions;

  bool can(String permission) => _permissions.contains(permission);

  bool canAny(Iterable<String> permissions) => permissions.any(can);

  bool canAll(Iterable<String> permissions) => permissions.every(can);
}

/// Permisos del usuario actual; vacío si no hay sesión.
final permissionServiceProvider = Provider<PermissionService>((ref) {
  final user = ref.watch(currentUserProvider);
  return user == null
      ? PermissionService.none
      : PermissionService(user.permissions);
});

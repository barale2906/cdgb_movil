import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/auth/permission_service.dart';

/// Muestra [child] solo si el usuario tiene [permission]; si no, [fallback]
/// (por defecto nada). Oculta acciones; la autorización real es del servidor.
class PermissionGate extends ConsumerWidget {
  const PermissionGate({
    required this.permission,
    required this.child,
    super.key,
    this.fallback = const SizedBox.shrink(),
  });

  final String permission;
  final Widget child;
  final Widget fallback;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allowed = ref.watch(permissionServiceProvider).can(permission);
    return allowed ? child : fallback;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/config/app_environment.dart';
import 'package:sga_bojanini/core/config/app_environment_provider.dart';
import 'package:sga_bojanini/core/network/api_exception.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/widgets/api_error_message.dart';
import 'package:sga_bojanini/core/widgets/skeleton.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Tarjeta de un bloque del tablero con sus tres estados: cargando
/// (esqueleto), error con reintento y datos. Cada bloque falla por separado.
class DashboardCard<T> extends ConsumerWidget {
  const DashboardCard({
    required this.title,
    required this.value,
    required this.onRetry,
    required this.builder,
    super.key,
    this.onTap,
  });

  final String title;
  final AsyncValue<T> value;
  final VoidCallback onRetry;
  final Widget Function(BuildContext context, T data) builder;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final isProd = ref.watch(appEnvironmentProvider).env == AppEnv.prod;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(child: Text(title, style: textTheme.titleSmall)),
                  if (onTap != null) const Icon(Icons.chevron_right),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              value.when(
                loading: () => const Column(
                  children: [
                    Skeleton(height: AppSpacing.lg),
                    SizedBox(height: AppSpacing.sm),
                    Skeleton(height: AppSpacing.lg),
                  ],
                ),
                error: (error, _) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      error is ApiException
                          ? ApiErrorMessage.of(l10n, error, isProd: isProd)
                          : l10n.dashBlockError,
                    ),
                    TextButton(
                      onPressed: onRetry,
                      child: Text(l10n.actionRetry),
                    ),
                  ],
                ),
                data: (data) => builder(context, data),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Cifra grande con su etiqueta.
class StatTile extends StatelessWidget {
  const StatTile({required this.label, required this.value, super.key});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Semantics(
      label: '$label: $value',
      child: ExcludeSemantics(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(value, style: textTheme.headlineSmall),
            Text(label, style: textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}

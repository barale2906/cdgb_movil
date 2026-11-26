import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';
import 'package:sga_bojanini/core/widgets/empty_state.dart';
import 'package:sga_bojanini/core/widgets/error_state.dart';
import 'package:sga_bojanini/core/widgets/skeleton.dart';
import 'package:sga_bojanini/features/purchasing/application/orders_providers.dart';
import 'package:sga_bojanini/features/purchasing/data/consolidation.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Productos bajo su punto de reorden con la cantidad sugerida a pedir.
class SuggestionsTab extends ConsumerWidget {
  const SuggestionsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final suggestions = ref.watch(suggestionsProvider);
    return suggestions.when(
      loading: () => const SkeletonList(),
      error: (error, _) => ErrorState(
        error: error,
        onRetry: () => ref.invalidate(suggestionsProvider),
      ),
      data: (items) => RefreshIndicator(
        onRefresh: () => ref.refresh(suggestionsProvider.future),
        child: items.isEmpty
            ? ListView(
                children: [
                  EmptyState(
                    icon: Icons.task_alt,
                    message: l10n.suggestionsEmpty,
                  ),
                ],
              )
            : ListView.builder(
                padding: const EdgeInsets.all(AppSpacing.md),
                itemCount: items.length,
                itemBuilder: (_, index) => _SuggestionCard(item: items[index]),
              ),
      ),
    );
  }
}

class _SuggestionCard extends StatelessWidget {
  const _SuggestionCard({required this.item});

  final ReorderSuggestion item;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(item.productName, style: textTheme.titleSmall),
            const SizedBox(height: AppSpacing.xs),
            Text(
              l10n.suggestionStock(
                AppFormat.decimal(item.currentStock ?? 0),
                AppFormat.decimal(item.reorderPoint ?? 0),
              ),
            ),
            if (item.preferredSupplier != null)
              Text(l10n.suggestionSupplier(item.preferredSupplier!.name)),
            if (item.leadTimeDays != null)
              Text(l10n.suggestionLeadTime(item.leadTimeDays!)),
            const SizedBox(height: AppSpacing.sm),
            Text(
              l10n.suggestionQuantity(
                AppFormat.decimal(item.suggestedQuantity ?? 0),
              ),
              style: textTheme.titleSmall,
            ),
          ],
        ),
      ),
    );
  }
}

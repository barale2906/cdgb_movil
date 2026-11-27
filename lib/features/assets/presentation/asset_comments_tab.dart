import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/auth/permission_service.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';
import 'package:sga_bojanini/core/widgets/app_snackbar.dart';
import 'package:sga_bojanini/core/widgets/bojani_button.dart';
import 'package:sga_bojanini/core/widgets/empty_state.dart';
import 'package:sga_bojanini/core/widgets/error_state.dart';
import 'package:sga_bojanini/core/widgets/skeleton.dart';
import 'package:sga_bojanini/core/widgets/write_feedback.dart';
import 'package:sga_bojanini/features/assets/application/assets_providers.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Comentarios del activo; quien tenga `activos.comentar` puede agregar.
/// No se editan ni se eliminan (regla del backend).
class AssetCommentsTab extends ConsumerStatefulWidget {
  const AssetCommentsTab({required this.assetId, super.key});

  final int assetId;

  @override
  ConsumerState<AssetCommentsTab> createState() => _AssetCommentsTabState();
}

class _AssetCommentsTabState extends ConsumerState<AssetCommentsTab> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _add() async {
    final l10n = AppLocalizations.of(context);
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    final saved = await ref
        .read(addCommentControllerProvider.notifier)
        .add(widget.assetId, text);
    if (!mounted) return;
    if (saved) {
      _controller.clear();
      AppSnackbar.show(context, l10n.assetCommentAdded);
      return;
    }
    showWriteError(
      context,
      ref,
      error: ref.read(addCommentControllerProvider).error,
      timeoutWarning: l10n.assetCommentTimeoutWarning,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final comments = ref.watch(assetCommentsProvider(widget.assetId));
    final canComment = ref
        .watch(permissionServiceProvider)
        .can('activos.comentar');
    final submitting = ref.watch(addCommentControllerProvider).isSubmitting;

    return Column(
      children: [
        Expanded(
          child: comments.when(
            loading: () => const SkeletonList(),
            error: (error, _) => ErrorState(
              error: error,
              onRetry: () =>
                  ref.invalidate(assetCommentsProvider(widget.assetId)),
            ),
            data: (items) => RefreshIndicator(
              onRefresh: () =>
                  ref.refresh(assetCommentsProvider(widget.assetId).future),
              child: items.isEmpty
                  ? ListView(
                      children: [
                        EmptyState(
                          icon: Icons.chat_bubble_outline,
                          message: l10n.assetCommentsEmpty,
                        ),
                      ],
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      itemCount: items.length,
                      itemBuilder: (_, index) {
                        final item = items[index];
                        return Card(
                          child: ListTile(
                            title: Text(item.comment),
                            subtitle: Text(
                              [
                                if (item.user != null) item.user!.name,
                                if (item.createdAt != null)
                                  AppFormat.dateTime(item.createdAt),
                              ].join(' · '),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ),
        ),
        if (canComment)
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              children: [
                TextField(
                  controller: _controller,
                  maxLines: 2,
                  decoration: InputDecoration(
                    labelText: l10n.assetCommentField,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                BojaniButton(
                  label: l10n.assetCommentAdd,
                  isLoading: submitting,
                  onPressed: () => unawaited(_add()),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

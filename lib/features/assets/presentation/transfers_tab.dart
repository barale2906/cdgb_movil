import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';
import 'package:sga_bojanini/core/widgets/choice_filter_bar.dart';
import 'package:sga_bojanini/core/widgets/paged_list_view.dart';
import 'package:sga_bojanini/features/assets/application/transfers_providers.dart';
import 'package:sga_bojanini/features/assets/data/asset_transfer.dart';
import 'package:sga_bojanini/features/assets/presentation/transfer_labels.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Traslados de activos, con filtro por estado (por defecto, pendientes de
/// firma: es lo que requiere acción).
class TransfersTab extends ConsumerStatefulWidget {
  const TransfersTab({super.key});

  @override
  ConsumerState<TransfersTab> createState() => _TransfersTabState();
}

class _TransfersTabState extends ConsumerState<TransfersTab> {
  TransferStatus? _status = TransferStatus.pendingSignature;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final provider = transferListProvider(_status);
    final notifier = ref.read(provider.notifier);
    return Column(
      children: [
        const SizedBox(height: AppSpacing.sm),
        ChoiceFilterBar<TransferStatus?>(
          options: {
            TransferStatus.pendingSignature: l10n.transferStatusPending,
            TransferStatus.confirmed: l10n.transferStatusConfirmed,
            TransferStatus.cancelled: l10n.transferStatusCancelled,
            null: l10n.filterAll,
          },
          selected: _status,
          onSelected: (value) => setState(() => _status = value),
        ),
        Expanded(
          child: PagedListView<AssetTransfer>(
            state: ref.watch(provider),
            onRefresh: notifier.refresh,
            onLoadMore: notifier.loadMore,
            onRetry: notifier.retry,
            emptyMessage: l10n.transfersEmpty,
            emptyIcon: Icons.swap_horiz,
            itemBuilder: (context, transfer) => _TransferTile(transfer),
          ),
        ),
      ],
    );
  }
}

class _TransferTile extends StatelessWidget {
  const _TransferTile(this.transfer);

  final AssetTransfer transfer;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final route = [
      if (transfer.from != null) transfer.from!,
      if (transfer.to != null) transfer.to!,
    ].join(' → ');
    return Card(
      child: ListTile(
        minTileHeight: AppSizes.minTouchTarget,
        title: Text(transfer.asset?.name ?? l10n.notAvailable),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              [
                transferTypeText(l10n, transfer),
                if (transfer.asset?.code != null) transfer.asset!.code!,
              ].join(' · '),
            ),
            if (route.isNotEmpty) Text(route),
            if (transfer.createdAt != null)
              Text(AppFormat.dateTime(transfer.createdAt)),
            const SizedBox(height: AppSpacing.xs),
            TransferStatusChip(status: transfer.status),
          ],
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => context.push('/assets/transfers/${transfer.id}'),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';
import 'package:sga_bojanini/core/widgets/paged_list_view.dart';
import 'package:sga_bojanini/features/inventory/application/inventory_providers.dart';
import 'package:sga_bojanini/features/inventory/data/movement_document.dart';
import 'package:sga_bojanini/features/inventory/presentation/inventory_labels.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Historial de movimientos individuales del almacén activo.
class HistoryTab extends ConsumerWidget {
  const HistoryTab({required this.warehouseId, super.key});

  final int warehouseId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final provider = movementListProvider(warehouseId);
    final notifier = ref.read(provider.notifier);
    return PagedListView<MovementLine>(
      state: ref.watch(provider),
      onRefresh: notifier.refresh,
      onLoadMore: notifier.loadMore,
      onRetry: notifier.retry,
      emptyMessage: l10n.historyEmpty,
      emptyIcon: Icons.history,
      itemBuilder: (context, line) => MovementLineTile(line: line),
    );
  }
}

/// Línea de movimiento: tipo, producto, lote y cantidad.
class MovementLineTile extends StatelessWidget {
  const MovementLineTile({required this.line, super.key, this.card = true});

  final MovementLine line;

  /// Envuelta en tarjeta (listas) o plana (dentro de un comprobante).
  final bool card;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final date = line.movementDate ?? line.createdAt;
    final tile = ListTile(
      minTileHeight: AppSizes.minTouchTarget,
      title: Text(line.productName ?? l10n.notAvailable),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(movementTypeLabel(l10n, line.movementType)),
          if (line.batchLotNumber != null)
            Text(l10n.batchLot(line.batchLotNumber!)),
          if (date != null) Text(AppFormat.date(date)),
        ],
      ),
      trailing: Text(
        AppFormat.decimal(line.quantity ?? 0, maxDecimals: 3),
        style: Theme.of(context).textTheme.labelLarge,
      ),
    );
    return card ? Card(child: tile) : tile;
  }
}

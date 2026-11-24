import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show FutureProviderFamily;
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/widgets/empty_state.dart';
import 'package:sga_bojanini/core/widgets/error_state.dart';
import 'package:sga_bojanini/core/widgets/search_field.dart';
import 'package:sga_bojanini/core/widgets/skeleton.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Lista con búsqueda: campo + estados cargando / vacío / error con
/// reintento + recarga por arrastre. [provider] recibe el texto buscado.
class SearchableList<T> extends ConsumerStatefulWidget {
  const SearchableList({
    required this.provider,
    required this.searchHint,
    required this.emptyMessage,
    required this.itemBuilder,
    super.key,
  });

  final FutureProviderFamily<List<T>, String> provider;
  final String searchHint;

  /// Mensaje cuando no hay datos y no se buscó nada.
  final String emptyMessage;
  final Widget Function(BuildContext context, T item) itemBuilder;

  @override
  ConsumerState<SearchableList<T>> createState() => _SearchableListState<T>();
}

class _SearchableListState<T> extends ConsumerState<SearchableList<T>>
    with AutomaticKeepAliveClientMixin {
  String _query = '';

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final l10n = AppLocalizations.of(context);
    final result = ref.watch(widget.provider(_query));

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: SearchField(
            hint: widget.searchHint,
            onChanged: (value) => setState(() => _query = value),
          ),
        ),
        Expanded(
          child: result.when(
            skipLoadingOnReload: true,
            loading: () => const SkeletonList(),
            error: (error, _) => ErrorState(
              error: error,
              onRetry: () => ref.invalidate(widget.provider(_query)),
            ),
            data: (items) => items.isEmpty
                ? EmptyState(
                    icon: Icons.search_off,
                    message: _query.isEmpty
                        ? widget.emptyMessage
                        : l10n.noResults,
                  )
                : RefreshIndicator(
                    onRefresh: () =>
                        ref.refresh(widget.provider(_query).future),
                    child: ListView.separated(
                      padding: const EdgeInsets.fromLTRB(
                        AppSpacing.md,
                        0,
                        AppSpacing.md,
                        AppSpacing.md,
                      ),
                      itemCount: items.length,
                      separatorBuilder: (_, _) =>
                          const SizedBox(height: AppSpacing.sm),
                      itemBuilder: (context, index) =>
                          widget.itemBuilder(context, items[index]),
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}

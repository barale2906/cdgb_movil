import 'package:flutter/material.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/utils/debouncer.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Campo de búsqueda: avisa con [onChanged] solo cuando el usuario deja de
/// escribir ([debounce]), para no consultar al servidor por cada letra.
class SearchField extends StatefulWidget {
  const SearchField({
    required this.hint,
    required this.onChanged,
    super.key,
    this.debounce = const Duration(milliseconds: 400),
  });

  final String hint;
  final ValueChanged<String> onChanged;
  final Duration debounce;

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final _controller = TextEditingController();
  late final Debouncer _debouncer = Debouncer(widget.debounce);

  @override
  void dispose() {
    _debouncer.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _clear() {
    _controller.clear();
    widget.onChanged('');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return TextField(
      controller: _controller,
      textInputAction: TextInputAction.search,
      onChanged: (value) {
        setState(() {});
        _debouncer.run(() => widget.onChanged(value.trim()));
      },
      onSubmitted: (value) => widget.onChanged(value.trim()),
      decoration: InputDecoration(
        hintText: widget.hint,
        prefixIcon: const Icon(Icons.search),
        suffixIcon: _controller.text.isEmpty
            ? null
            : IconButton(
                tooltip: l10n.searchClear,
                constraints: const BoxConstraints(
                  minWidth: AppSizes.minTouchTarget,
                  minHeight: AppSizes.minTouchTarget,
                ),
                icon: const Icon(Icons.close),
                onPressed: _clear,
              ),
      ),
    );
  }
}

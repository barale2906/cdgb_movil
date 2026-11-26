import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';
import 'package:sga_bojanini/core/widgets/bojani_button.dart';
import 'package:sga_bojanini/core/widgets/form_fields.dart';
import 'package:sga_bojanini/features/auth/application/validators.dart';
import 'package:sga_bojanini/features/purchasing/data/expense_orders_repository.dart';
import 'package:sga_bojanini/features/purchasing/data/order_status.dart';
import 'package:sga_bojanini/features/purchasing/presentation/purchasing_labels.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

String _isoDate(DateTime date) => date.toIso8601String().substring(0, 10);

/// Marco común de los diálogos de captura: campos, validación y botones
/// apilados a todo el ancho.
class _FormDialog extends StatelessWidget {
  const _FormDialog({
    required this.title,
    required this.formKey,
    required this.confirmLabel,
    required this.onConfirm,
    required this.children,
  });

  final String title;
  final GlobalKey<FormState> formKey;
  final String confirmLabel;
  final VoidCallback onConfirm;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AlertDialog(
      title: Text(title),
      content: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(mainAxisSize: MainAxisSize.min, children: children),
        ),
      ),
      actionsPadding: const EdgeInsets.all(AppSpacing.md),
      actionsOverflowDirection: VerticalDirection.down,
      actions: [
        BojaniButton(label: confirmLabel, onPressed: onConfirm),
        const SizedBox(height: AppSpacing.sm),
        BojaniButton(
          label: l10n.actionCancel,
          kind: BojaniButtonKind.tertiary,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}

/// Número y fecha de la factura. Devuelve `null` si se cancela.
Future<({String number, String date})?> askInvoice(BuildContext context) =>
    showDialog<({String number, String date})>(
      context: context,
      builder: (_) => const _InvoiceDialog(),
    );

class _InvoiceDialog extends StatefulWidget {
  const _InvoiceDialog();

  @override
  State<_InvoiceDialog> createState() => _InvoiceDialogState();
}

class _InvoiceDialogState extends State<_InvoiceDialog> {
  final _formKey = GlobalKey<FormState>();
  final _number = TextEditingController();
  DateTime? _date;

  @override
  void dispose() {
    _number.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return _FormDialog(
      title: l10n.expenseInvoiceTitle,
      formKey: _formKey,
      confirmLabel: l10n.actionSave,
      onConfirm: () {
        if (!(_formKey.currentState?.validate() ?? false)) return;
        Navigator.of(
          context,
        ).pop((number: _number.text.trim(), date: _isoDate(_date!)));
      },
      children: [
        TextFormField(
          controller: _number,
          decoration: InputDecoration(labelText: l10n.fieldInvoiceNumber),
          validator: (v) =>
              (v ?? '').trim().isEmpty ? l10n.validationRequired : null,
        ),
        const SizedBox(height: AppSpacing.md),
        DateField(
          label: l10n.fieldInvoiceDate,
          required: true,
          value: _date,
          onChanged: (value) => setState(() => _date = value),
        ),
      ],
    );
  }
}

/// Datos de un pago. Devuelve `null` si se cancela. [balance] es el saldo
/// pendiente: no se admite un pago mayor.
Future<PaymentRequest?> askPayment(BuildContext context, double balance) =>
    showDialog<PaymentRequest>(
      context: context,
      builder: (_) => _PaymentDialog(balance: balance),
    );

class _PaymentDialog extends StatefulWidget {
  const _PaymentDialog({required this.balance});

  final double balance;

  @override
  State<_PaymentDialog> createState() => _PaymentDialogState();
}

class _PaymentDialogState extends State<_PaymentDialog> {
  final _formKey = GlobalKey<FormState>();
  final _amount = TextEditingController();
  final _reference = TextEditingController();
  final _notes = TextEditingController();
  DateTime? _date = DateTime.now();
  PaymentMethod _method = PaymentMethod.transfer;

  @override
  void dispose() {
    _amount.dispose();
    _reference.dispose();
    _notes.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return _FormDialog(
      title: l10n.expensePaymentTitle,
      formKey: _formKey,
      confirmLabel: l10n.actionSave,
      onConfirm: () {
        if (!(_formKey.currentState?.validate() ?? false)) return;
        Navigator.of(context).pop(
          PaymentRequest(
            amount: AppFormat.parseDecimal(_amount.text)!,
            paymentDate: _isoDate(_date!),
            method: _method,
            reference: _reference.text,
            notes: _notes.text,
          ),
        );
      },
      children: [
        Text(l10n.expenseBalanceHint(money(widget.balance))),
        const SizedBox(height: AppSpacing.md),
        TextFormField(
          controller: _amount,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
          ],
          decoration: InputDecoration(labelText: l10n.fieldAmount),
          validator: (value) {
            final amount = AppFormat.parseDecimal(value);
            if (amount == null || amount <= 0) return l10n.validationPositive;
            return amount > widget.balance ? l10n.expenseAmountExceeds : null;
          },
        ),
        const SizedBox(height: AppSpacing.md),
        OptionDropdown<PaymentMethod>(
          label: l10n.fieldPaymentMethod,
          options: {
            for (final method in PaymentMethod.values)
              method: paymentMethodLabel(l10n, method.value),
          },
          value: _method,
          onChanged: (value) => setState(() => _method = value ?? _method),
        ),
        const SizedBox(height: AppSpacing.md),
        DateField(
          label: l10n.fieldPaymentDate,
          required: true,
          value: _date,
          onChanged: (value) => setState(() => _date = value),
        ),
        const SizedBox(height: AppSpacing.md),
        TextFormField(
          controller: _reference,
          decoration: InputDecoration(labelText: l10n.fieldReference),
        ),
        const SizedBox(height: AppSpacing.md),
        TextFormField(
          controller: _notes,
          decoration: InputDecoration(labelText: l10n.fieldNotes),
        ),
      ],
    );
  }
}

/// Correos de contabilidad a los que se envía la orden. `null` si se cancela.
Future<List<String>?> askAccountingRecipients(BuildContext context) =>
    showDialog<List<String>>(
      context: context,
      builder: (_) => const _RecipientsDialog(),
    );

class _RecipientsDialog extends StatefulWidget {
  const _RecipientsDialog();

  @override
  State<_RecipientsDialog> createState() => _RecipientsDialogState();
}

class _RecipientsDialogState extends State<_RecipientsDialog> {
  final _formKey = GlobalKey<FormState>();
  final _recipients = TextEditingController();

  @override
  void dispose() {
    _recipients.dispose();
    super.dispose();
  }

  List<String> get _parsed => _recipients.text
      .split(RegExp(r'[,;\s]+'))
      .where((email) => email.isNotEmpty)
      .toList();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return _FormDialog(
      title: l10n.expenseAccountingTitle,
      formKey: _formKey,
      confirmLabel: l10n.sendEmailAction,
      onConfirm: () {
        if (_formKey.currentState?.validate() ?? false) {
          Navigator.of(context).pop(_parsed);
        }
      },
      children: [
        TextFormField(
          controller: _recipients,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(labelText: l10n.fieldRecipients),
          validator: (_) {
            final emails = _parsed;
            final valid =
                emails.isNotEmpty &&
                emails.every((e) => Validators.email(l10n, e) == null);
            return valid ? null : l10n.validationEmails;
          },
        ),
      ],
    );
  }
}

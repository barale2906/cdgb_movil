import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/clinical/medsys_patient.dart';
import 'package:sga_bojanini/core/clinical/procedure_match.dart';
import 'package:sga_bojanini/core/config/app_environment.dart';
import 'package:sga_bojanini/core/config/app_environment_provider.dart';
import 'package:sga_bojanini/core/network/api_exception.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';
import 'package:sga_bojanini/core/widgets/alert_banner.dart';
import 'package:sga_bojanini/core/widgets/api_error_message.dart';
import 'package:sga_bojanini/core/widgets/app_snackbar.dart';
import 'package:sga_bojanini/core/widgets/bojani_button.dart';
import 'package:sga_bojanini/core/widgets/bojani_text_field.dart';
import 'package:sga_bojanini/core/widgets/form_fields.dart';
import 'package:sga_bojanini/core/widgets/offline_banner.dart';
import 'package:sga_bojanini/core/widgets/patient_selector.dart';
import 'package:sga_bojanini/core/widgets/status_chip.dart';
import 'package:sga_bojanini/features/service_orders/application/new_order_controller.dart';
import 'package:sga_bojanini/features/service_orders/application/service_orders_providers.dart';
import 'package:sga_bojanini/features/service_orders/presentation/order_detail_page.dart';
import 'package:sga_bojanini/features/service_orders/presentation/order_line_card.dart';
import 'package:sga_bojanini/features/service_orders/presentation/order_paths.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Nueva orden de servicio: paciente de MedSys, uno o más procedimientos con
/// descuento e insumos opcionales. Se crea con un solo envío.
class NewOrderPage extends ConsumerStatefulWidget {
  const NewOrderPage({super.key});

  @override
  ConsumerState<NewOrderPage> createState() => _NewOrderPageState();
}

class _NewOrderPageState extends ConsumerState<NewOrderPage> {
  final _formKey = GlobalKey<FormState>();
  bool _attempted = false;

  Future<void> _pickPatient() async {
    final patient = await context.push<MedsysPatient>(OrderPaths.patient);
    if (patient != null) {
      ref.read(newOrderProvider.notifier).setPatient(patient);
    }
  }

  Future<void> _addService() async {
    final service = await context.push<ProcedureMatch>(OrderPaths.service);
    if (service != null) ref.read(newOrderProvider.notifier).addLine(service);
  }

  Future<void> _submit() async {
    setState(() => _attempted = true);
    final formValid = _formKey.currentState?.validate() ?? false;
    final state = ref.read(newOrderProvider);
    if (!formValid || state.patient == null || state.lines.isEmpty) return;
    final order = await ref.read(newOrderProvider.notifier).submit();
    if (!mounted || order == null) return;
    ref
      ..invalidate(pendingDiscountsProvider)
      ..invalidate(serviceOrderProvider(order.orderNumber));
    AppSnackbar.show(
      context,
      AppLocalizations.of(context).serviceOrderCreated(order.orderNumber),
    );
    context.pushReplacement(OrderDetailPage.pathFor(order.orderNumber));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final state = ref.watch(newOrderProvider);
    final notifier = ref.read(newOrderProvider.notifier);
    final today = DateTime.now();
    final canWrite = ref.watch(canWriteProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.serviceOrderFormTitle)),
      body: SafeArea(
        child: Column(
          children: [
            const OfflineBanner(),
            Expanded(
              child: Form(
                key: _formKey,
                child: ListView(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  children: [
                    PatientSelector(
                      patient: state.patient,
                      canChange: !state.isSubmitting,
                      showError: _attempted && state.patient == null,
                      onPick: _pickPatient,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    IgnorePointer(
                      ignoring: state.isSubmitting,
                      child: DateField(
                        label: l10n.saleServiceDate,
                        value: state.serviceDate,
                        required: true,
                        lastDate: DateTime(today.year, today.month, today.day),
                        onChanged: (date) {
                          if (date != null) notifier.setServiceDate(date);
                        },
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    BojaniTextField(
                      label: l10n.saleSeller,
                      enabled: !state.isSubmitting,
                      textInputAction: TextInputAction.next,
                      onChanged: notifier.setSeller,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    BojaniTextField(
                      label: l10n.saleReferrer,
                      enabled: !state.isSubmitting,
                      textInputAction: TextInputAction.next,
                      onChanged: notifier.setReferrer,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    BojaniTextField(
                      label: l10n.serviceOrderNotes,
                      enabled: !state.isSubmitting,
                      onChanged: notifier.setNotes,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Text(
                      l10n.serviceOrderProcedures,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    for (final line in state.lines) ...[
                      OrderLineCard(key: ValueKey(line.key), line: line),
                      const SizedBox(height: AppSpacing.sm),
                    ],
                    if (_attempted && state.lines.isEmpty)
                      Text(
                        l10n.saleServicesRequired,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    BojaniButton(
                      label: l10n.saleAddService,
                      icon: Icons.add,
                      kind: BojaniButtonKind.secondary,
                      onPressed: state.isSubmitting
                          ? null
                          : () => unawaited(_addService()),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _Totals(state: state),
                    if (state.error != null) ...[
                      const SizedBox(height: AppSpacing.md),
                      _SubmitError(error: state.error!),
                    ],
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: BojaniButton(
                label: l10n.serviceOrderSubmit,
                isLoading: state.isSubmitting,
                onPressed: canWrite && !state.isUnconfirmed
                    ? () => unawaited(_submit())
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Totals extends StatelessWidget {
  const _Totals({required this.state});

  final NewOrderState state;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${l10n.serviceOrderTotal}: ${AppFormat.cop(state.total)}',
          style: textTheme.bodyLarge,
        ),
        if (state.hasDiscount)
          Text(
            '${l10n.serviceOrderDiscount}: '
            '${AppFormat.cop(state.totalDiscount)}',
            style: textTheme.bodyLarge,
          ),
        Text(
          '${l10n.serviceOrderNetTotal}: ${AppFormat.cop(state.netTotal)}',
          style: textTheme.titleMedium,
        ),
      ],
    );
  }
}

/// Error de la creación. Si no hubo respuesta o el servidor falló al guardar,
/// la orden pudo quedar creada (total o parcialmente): se pide revisar antes
/// de repetir, nunca se reintenta sola.
class _SubmitError extends ConsumerWidget {
  const _SubmitError({required this.error});

  final ApiException error;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final isProd = ref.watch(appEnvironmentProvider).env == AppEnv.prod;
    final timedOut =
        error is NetworkException &&
        (error as NetworkException).kind == NetworkFailureKind.timeout;
    final maybePartial =
        error is BusinessRuleException || error is ServerException;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AlertBanner(
          message: ApiErrorMessage.ofWrite(
            l10n,
            error,
            isProd: isProd,
            timeoutWarning: l10n.serviceOrderUnconfirmed,
          ),
          kind: StatusKind.error,
          icon: Icons.error_outline,
        ),
        if (maybePartial) ...[
          const SizedBox(height: AppSpacing.sm),
          Text(l10n.serviceOrderMaybePartial),
        ],
        if (timedOut)
          Consumer(
            builder: (context, ref, _) => BojaniButton(
              label: l10n.serviceOrderNotCreated,
              kind: BojaniButtonKind.tertiary,
              onPressed: ref
                  .read(newOrderProvider.notifier)
                  .acknowledgeNotCreated,
            ),
          ),
      ],
    );
  }
}

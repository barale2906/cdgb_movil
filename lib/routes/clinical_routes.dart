import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/auth/permission_service.dart';
import 'package:sga_bojanini/core/clinical/medsys_patient.dart';
import 'package:sga_bojanini/core/navigation/quick_action_permissions.dart';
import 'package:sga_bojanini/core/router/redirect.dart';
import 'package:sga_bojanini/core/widgets/clinical_pickers.dart';
import 'package:sga_bojanini/features/clinical/data/evolution.dart';
import 'package:sga_bojanini/features/clinical/presentation/evolution_form_page.dart';
import 'package:sga_bojanini/features/clinical/presentation/patient_detail_page.dart';
import 'package:sga_bojanini/features/clinical/presentation/record_detail_page.dart';
import 'package:sga_bojanini/features/clinical/presentation/sale_page.dart';
import 'package:sga_bojanini/routes/route_guards.dart';

/// Registros clínicos: detalle de un registro y ficha del paciente (la lista
/// es la sección `/clinical-records`).
List<GoRoute> clinicalRoutes(Ref ref) {
  const base = '/clinical-records';
  const permission = 'registros_procedimientos.ver';
  return [
    GoRoute(
      path: SalePage.path,
      redirect: requiresAll(ref, QuickActionPermissions.sale),
      builder: (_, _) => const SalePage(),
      routes: [
        GoRoute(path: 'patient', builder: (_, _) => const PatientPickerPage()),
        GoRoute(path: 'service', builder: (_, _) => const ServicePickerPage()),
      ],
    ),
    GoRoute(
      path: '$base/records/:id',
      redirect: requires(ref, permission),
      builder: (_, state) => RecordDetailPage(recordId: routeId(state)),
      routes: [
        GoRoute(
          path: 'evolution',
          redirect: (context, state) =>
              ref.read(permissionServiceProvider).canAny(const [
                'evoluciones_clinicas.crear',
                'evoluciones_clinicas.editar',
              ])
              ? null
              : Routes.home,
          builder: (_, state) => EvolutionFormPage(
            recordId: routeId(state),
            evolution: state.extra is Evolution
                ? state.extra! as Evolution
                : null,
          ),
        ),
      ],
    ),
    GoRoute(
      path: '$base/patients/:id',
      redirect: requires(ref, permission),
      builder: (_, state) => PatientDetailPage(
        externalId: state.pathParameters['id']!,
        patient: state.extra is MedsysPatient
            ? state.extra! as MedsysPatient
            : null,
      ),
    ),
  ];
}

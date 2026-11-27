import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/files/file_picker_gateway.dart';
import 'package:sga_bojanini/core/navigation/app_section.dart';
import 'package:sga_bojanini/core/widgets/pdf_preview_page.dart';
import 'package:sga_bojanini/features/assets/application/assets_providers.dart';
import 'package:sga_bojanini/features/assets/application/transfers_providers.dart';
import 'package:sga_bojanini/features/assets/presentation/asset_detail_page.dart';
import 'package:sga_bojanini/features/assets/presentation/asset_form_page.dart';
import 'package:sga_bojanini/features/assets/presentation/document_upload_page.dart';
import 'package:sga_bojanini/features/assets/presentation/maintenance_plan_form_page.dart';
import 'package:sga_bojanini/features/assets/presentation/schedule_maintenance_page.dart';
import 'package:sga_bojanini/features/assets/presentation/technical_profile_form_page.dart';
import 'package:sga_bojanini/features/assets/presentation/transfer_confirm_page.dart';
import 'package:sga_bojanini/features/assets/presentation/transfer_detail_page.dart';
import 'package:sga_bojanini/features/assets/presentation/transfer_request_page.dart';
import 'package:sga_bojanini/features/home/presentation/section_placeholder_page.dart';
import 'package:sga_bojanini/routes/route_guards.dart';

/// Ficha y hoja de vida de un activo (la lista es la sección `/assets`).
List<GoRoute> assetRoutes(Ref ref) => [
  GoRoute(
    path: '/assets/transfers/:id',
    redirect: requires(ref, 'activos.ver'),
    builder: (_, state) => TransferDetailPage(transferId: routeId(state)),
    routes: [
      GoRoute(
        path: 'confirm',
        redirect: requires(ref, 'activos_traslados.confirmar'),
        builder: (_, state) => TransferConfirmPage(transferId: routeId(state)),
      ),
      GoRoute(
        path: 'act',
        builder: (_, state) => PdfPreviewPage(
          provider: transferActProvider(routeId(state)),
          fileName: 'acta-traslado-${routeId(state)}.pdf',
        ),
      ),
    ],
  ),
  // Antes de `/assets/:id`: "new" no es un identificador.
  GoRoute(
    path: AssetFormPage.newPath,
    redirect: requires(ref, 'activos.crear'),
    builder: (_, _) => const AssetFormPage(),
  ),
  GoRoute(
    path: '/assets/:id',
    redirect: requires(ref, 'activos.ver'),
    builder: (_, state) => AssetDetailPage(assetId: routeId(state)),
    routes: [
      GoRoute(
        path: 'edit',
        redirect: requires(ref, 'activos.editar'),
        builder: (_, state) => AssetFormPage(assetId: routeId(state)),
      ),
      GoRoute(
        path: 'technical-profile',
        redirect: requires(ref, 'activos.editar'),
        builder: (_, state) =>
            TechnicalProfileFormPage(assetId: routeId(state)),
      ),
      GoRoute(
        path: 'maintenance/new',
        redirect: requires(ref, 'activos_mantenimientos.programar'),
        builder: (_, state) => ScheduleMaintenancePage(assetId: routeId(state)),
      ),
      GoRoute(
        path: 'plans/new',
        redirect: requires(ref, 'activos_mantenimientos.programar'),
        builder: (_, state) => MaintenancePlanFormPage(assetId: routeId(state)),
      ),
      GoRoute(
        path: 'plans/:planId/edit',
        redirect: requires(ref, 'activos_mantenimientos.programar'),
        builder: (_, state) => MaintenancePlanFormPage(
          assetId: routeId(state),
          planId: int.parse(state.pathParameters['planId']!),
        ),
      ),
      GoRoute(
        path: 'transfer',
        redirect: requires(ref, 'activos_traslados.solicitar'),
        builder: (_, state) => TransferRequestPage(assetId: routeId(state)),
      ),
      GoRoute(
        path: 'documents/new',
        redirect: requires(ref, 'activos_documentos.cargar'),
        // El archivo elegido viaja en memoria (extra); sin él no hay nada
        // que subir.
        builder: (_, state) => state.extra is PickedFile
            ? DocumentUploadPage(
                assetId: routeId(state),
                file: state.extra! as PickedFile,
              )
            : const SectionPlaceholderPage(section: AppSection.assets),
      ),
      GoRoute(
        path: 'life-sheet',
        builder: (_, state) => PdfPreviewPage(
          provider: lifeSheetProvider(routeId(state)),
          fileName: 'hoja-de-vida-${routeId(state)}.pdf',
        ),
      ),
    ],
  ),
];

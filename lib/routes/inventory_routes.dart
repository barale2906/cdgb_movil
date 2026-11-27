import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/features/inventory/application/movement_permissions.dart';
import 'package:sga_bojanini/features/inventory/presentation/batch_detail_page.dart';
import 'package:sga_bojanini/features/inventory/presentation/confirm_document_page.dart';
import 'package:sga_bojanini/features/inventory/presentation/document_detail_page.dart';
import 'package:sga_bojanini/features/inventory/presentation/document_pdf_page.dart';
import 'package:sga_bojanini/features/inventory/presentation/entry_form_page.dart';
import 'package:sga_bojanini/features/inventory/presentation/exit_form_page.dart';
import 'package:sga_bojanini/features/inventory/presentation/new_movement_page.dart';
import 'package:sga_bojanini/features/inventory/presentation/scan_page.dart';
import 'package:sga_bojanini/features/inventory/presentation/single_movement_page.dart';
import 'package:sga_bojanini/features/inventory/presentation/transfer_form_page.dart';
import 'package:sga_bojanini/routes/route_guards.dart';

/// Pantallas de inventario fuera de la barra inferior (detalles, formularios
/// de movimiento, confirmación, PDF y escáner).
List<GoRoute> inventoryRoutes(Ref ref) {
  const base = '/inventory';
  return [
    GoRoute(
      path: '$base/batches/:id',
      redirect: requires(ref, 'lotes.ver'),
      builder: (_, state) => BatchDetailPage(batchId: routeId(state)),
    ),
    GoRoute(
      path: '$base/documents/:id',
      builder: (_, state) => DocumentDetailPage(documentId: routeId(state)),
      routes: [
        GoRoute(
          path: 'confirm',
          redirect: requires(ref, 'movimientos.confirmar'),
          builder: (_, state) =>
              ConfirmDocumentPage(documentId: routeId(state)),
        ),
        GoRoute(
          path: 'pdf',
          builder: (_, state) => DocumentPdfPage(documentId: routeId(state)),
        ),
      ],
    ),
    GoRoute(
      path: NewMovementPage.path,
      builder: (_, _) => const NewMovementPage(),
    ),
    GoRoute(
      path: MovementKind.entry.path,
      redirect: requires(ref, MovementKind.entry.permission),
      builder: (_, _) => const EntryFormPage(),
    ),
    GoRoute(
      path: MovementKind.exit.path,
      redirect: requires(ref, MovementKind.exit.permission),
      builder: (_, _) => const ExitFormPage(),
    ),
    GoRoute(
      path: MovementKind.transfer.path,
      redirect: requires(ref, MovementKind.transfer.permission),
      builder: (_, _) => const TransferFormPage(),
    ),
    for (final kind in [
      MovementKind.adjustment,
      MovementKind.returnStock,
      MovementKind.writeOff,
      MovementKind.loss,
    ])
      GoRoute(
        path: kind.path,
        redirect: requires(ref, kind.permission),
        builder: (_, _) => SingleMovementPage(kind: kind),
      ),
    GoRoute(
      path: ScanPage.path,
      // La cámara es común: la usan productos y activos, y el destino que
      // abre el código valida su propio permiso.
      redirect: requiresAny(ref, ['generic-products.barcode', 'activos.ver']),
      builder: (_, _) => const ScanPage(),
    ),
  ];
}

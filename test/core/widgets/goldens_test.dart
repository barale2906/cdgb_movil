import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/widgets/alert_banner.dart';
import 'package:sga_bojanini/core/widgets/bojani_button.dart';
import 'package:sga_bojanini/core/widgets/empty_state.dart';
import 'package:sga_bojanini/core/widgets/status_chip.dart';

import '../../helpers/pump_app.dart';

/// Goldens de los componentes base (CLAUDE.md §7). Regenerar con
/// `flutter test --update-goldens test/core/widgets/goldens_test.dart`.
void main() {
  Future<void> pumpOnCanvas(WidgetTester tester, Widget child) async {
    tester.view
      ..physicalSize = const Size(400, 640)
      ..devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpApp(
      RepaintBoundary(
        child: ColoredBox(
          color: AppColors.background,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: child,
          ),
        ),
      ),
    );
  }

  testWidgets('BojaniButton: variantes y estados', (tester) async {
    await pumpOnCanvas(
      tester,
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BojaniButton(label: 'Principal', onPressed: () {}),
          const SizedBox(height: AppSpacing.sm),
          BojaniButton(
            label: 'Secundario',
            kind: BojaniButtonKind.secondary,
            onPressed: () {},
          ),
          const SizedBox(height: AppSpacing.sm),
          BojaniButton(
            label: 'Terciario',
            kind: BojaniButtonKind.tertiary,
            onPressed: () {},
          ),
          const SizedBox(height: AppSpacing.sm),
          BojaniButton(
            label: 'Destructivo',
            kind: BojaniButtonKind.destructive,
            onPressed: () {},
          ),
          const SizedBox(height: AppSpacing.sm),
          const BojaniButton(label: 'Deshabilitado', onPressed: null),
        ],
      ),
    );

    await expectLater(
      find.byType(RepaintBoundary).first,
      matchesGoldenFile('goldens/bojani_button.png'),
    );
  });

  testWidgets('StatusChip: los cinco estados', (tester) async {
    await pumpOnCanvas(
      tester,
      const Wrap(
        spacing: AppSpacing.sm,
        runSpacing: AppSpacing.sm,
        children: [
          StatusChip(label: 'Confirmado', kind: StatusKind.success),
          StatusChip(label: 'Vencido', kind: StatusKind.error),
          StatusChip(label: 'Por vencer', kind: StatusKind.warning),
          StatusChip(label: 'Borrador', kind: StatusKind.info),
          StatusChip(label: 'En revisión', kind: StatusKind.special),
        ],
      ),
    );

    await expectLater(
      find.byType(RepaintBoundary).first,
      matchesGoldenFile('goldens/status_chip.png'),
    );
  });

  testWidgets('AlertBanner y EmptyState', (tester) async {
    await pumpOnCanvas(
      tester,
      Column(
        children: [
          const AlertBanner(
            message:
                'Sin conexión. Las acciones que guardan datos están '
                'deshabilitadas.',
            kind: StatusKind.warning,
            icon: Icons.cloud_off_outlined,
          ),
          const SizedBox(height: AppSpacing.md),
          const AlertBanner(
            message: 'No se pudo guardar.',
            kind: StatusKind.error,
            actionLabel: 'Reintentar',
            onAction: _noop,
          ),
          Expanded(
            child: EmptyState(
              icon: Icons.inbox_outlined,
              title: 'Sin registros',
              message: 'Aún no hay información para mostrar.',
              actionLabel: 'Actualizar',
              onAction: () {},
            ),
          ),
        ],
      ),
    );

    await expectLater(
      find.byType(RepaintBoundary).first,
      matchesGoldenFile('goldens/banner_and_empty_state.png'),
    );
  });
}

void _noop() {}

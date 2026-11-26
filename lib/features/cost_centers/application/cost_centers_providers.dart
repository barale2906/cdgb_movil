import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show FutureProviderFamily;
import 'package:sga_bojanini/features/cost_centers/data/cost_centers_repository.dart';
import 'package:sga_bojanini/features/cost_centers/data/medical_service_node.dart';

final FutureProvider<List<MedicalServiceNode>> serviceTreeProvider =
    FutureProvider.autoDispose<List<MedicalServiceNode>>(
      (ref) => ref.watch(serviceCatalogRepositoryProvider).tree(),
    );

final FutureProviderFamily<List<ProcedurePrice>, int> procedurePricesProvider =
    FutureProvider.autoDispose.family<List<ProcedurePrice>, int>(
      (ref, id) => ref.watch(serviceCatalogRepositoryProvider).prices(id),
    );

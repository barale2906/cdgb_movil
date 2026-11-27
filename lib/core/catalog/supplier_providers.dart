import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show FutureProviderFamily;
import 'package:sga_bojanini/core/catalog/supplier.dart';
import 'package:sga_bojanini/core/catalog/supplier_repository.dart';

final FutureProviderFamily<List<Supplier>, String> supplierSearchProvider =
    FutureProvider.autoDispose.family<List<Supplier>, String>(
      (ref, search) =>
          ref.watch(supplierRepositoryProvider).suppliers(search: search),
    );

final FutureProviderFamily<Supplier, int> supplierDetailProvider =
    FutureProvider.autoDispose.family<Supplier, int>(
      (ref, id) => ref.watch(supplierRepositoryProvider).supplier(id),
    );

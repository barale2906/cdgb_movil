import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show FutureProviderFamily;
import 'package:sga_bojanini/core/utils/submission_notifier.dart';
import 'package:sga_bojanini/features/inventory/application/inventory_providers.dart';
import 'package:sga_bojanini/features/inventory/data/inventory_repository.dart';
import 'package:sga_bojanini/features/inventory/data/movement_document.dart';
import 'package:sga_bojanini/features/inventory/data/movement_requests.dart';

/// Confirma un comprobante con firma/PIN. Es una escritura: nunca se
/// reintenta sola; tras un timeout hay que consultar el estado primero.
class ConfirmDocumentController extends SubmissionNotifier {
  Future<MovementDocument?> confirm(int id, ConfirmRequest request) async {
    final result = await runValue(
      () => ref.read(inventoryRepositoryProvider).confirm(id, request),
    );
    if (result != null) _refresh(id);
    return result;
  }

  void _refresh(int id) {
    ref
      ..invalidate(documentDetailProvider(id))
      ..invalidate(documentListProvider)
      ..invalidate(stockListProvider)
      ..invalidate(lowStockProvider)
      ..invalidate(batchListProvider)
      ..invalidate(movementListProvider);
  }
}

final NotifierProvider<ConfirmDocumentController, SubmissionState>
confirmDocumentControllerProvider =
    NotifierProvider.autoDispose<ConfirmDocumentController, SubmissionState>(
      ConfirmDocumentController.new,
    );

class CancelDocumentController extends SubmissionNotifier {
  Future<bool> cancel(int id) async {
    final done = await run(
      () => ref.read(inventoryRepositoryProvider).cancelPending(id),
    );
    if (done) {
      ref
        ..invalidate(documentDetailProvider(id))
        ..invalidate(documentListProvider);
    }
    return done;
  }
}

final NotifierProvider<CancelDocumentController, SubmissionState>
cancelDocumentControllerProvider =
    NotifierProvider.autoDispose<CancelDocumentController, SubmissionState>(
      CancelDocumentController.new,
    );

class SendEmailController extends SubmissionNotifier {
  Future<bool> send(int id, List<String> recipients) => run(
    () => ref.read(inventoryRepositoryProvider).sendEmail(id, recipients),
  );
}

final NotifierProvider<SendEmailController, SubmissionState>
sendEmailControllerProvider =
    NotifierProvider.autoDispose<SendEmailController, SubmissionState>(
      SendEmailController.new,
    );

/// PDF del comprobante (binario).
final FutureProviderFamily<Uint8List, int> documentPdfProvider = FutureProvider
    .autoDispose
    .family<Uint8List, int>(
      (ref, id) => ref.watch(inventoryRepositoryProvider).pdf(id),
    );

/// Imagen de firma (`delivered_by` / `received_by`) bajo demanda.
final FutureProviderFamily<String?, ({int documentId, String role})>
signatureImageProvider = FutureProvider.autoDispose
    .family<String?, ({int documentId, String role})>(
      (ref, key) => ref
          .watch(inventoryRepositoryProvider)
          .signatureImage(key.documentId, key.role),
    );

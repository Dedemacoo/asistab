import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../services/local_db/isar_service.dart';
import '../domain/obligation_model.dart';
import 'local_obligation.dart';

class ObligationRepository {
  final IsarService _isarService;

  ObligationRepository(this._isarService);

  Future<List<ObligationModel>> getObligations() async {
    final localList = await _isarService.getAllObligations();
    return localList.map((local) => _toModel(local)).toList();
  }

  Future<void> addObligation(ObligationModel obligation) async {
    final local = _toLocal(obligation);
    await _isarService.saveObligation(local);
  }

  Future<void> deleteObligation(String id) async {
    await _isarService.deleteObligation(id);
  }

  ObligationModel _toModel(LocalObligation local) {
    return ObligationModel(
      id: local.uuid,
      userId: local.userId,
      title: local.title,
      category: local.category,
      amount: local.amount,
      deadline: local.deadline,
      isPaid: local.isPaid,
      riskScore: local.riskScore,
      createdAt: local.createdAt,
      documentUrl: local.documentUrl,
    );
  }

  LocalObligation _toLocal(ObligationModel model) {
    return LocalObligation()
      ..uuid = model.id
      ..userId = model.userId
      ..title = model.title
      ..category = model.category
      ..amount = model.amount
      ..deadline = model.deadline
      ..isPaid = model.isPaid
      ..riskScore = model.riskScore
      ..createdAt = model.createdAt
      ..documentUrl = model.documentUrl;
  }
}

final obligationRepositoryProvider = Provider<ObligationRepository>((ref) {
  final isarService = ref.watch(isarServiceProvider);
  return ObligationRepository(isarService);
});

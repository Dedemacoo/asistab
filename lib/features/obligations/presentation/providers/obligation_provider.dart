import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';
import '../../domain/obligation_model.dart';
import '../../data/obligation_repository.dart';

class ObligationState {
  final List<ObligationModel> obligations;
  final bool isLoading;
  final int overallRiskScore;

  ObligationState({
    this.obligations = const [],
    this.isLoading = false,
    this.overallRiskScore = 0,
  });

  ObligationState copyWith({
    List<ObligationModel>? obligations,
    bool? isLoading,
    int? overallRiskScore,
  }) {
    return ObligationState(
      obligations: obligations ?? this.obligations,
      isLoading: isLoading ?? this.isLoading,
      overallRiskScore: overallRiskScore ?? this.overallRiskScore,
    );
  }
}

class ObligationNotifier extends StateNotifier<ObligationState> {
  final ObligationRepository _repository;

  ObligationNotifier(this._repository) : super(ObligationState(isLoading: true)) {
    loadObligations();
  }

  Future<void> loadObligations() async {
    try {
      state = state.copyWith(isLoading: true);
      final obligations = await _repository.getObligations();
      
      // Yüklendikten sonra tarihe göre sıralayalım (En yakın tarih en üstte)
      obligations.sort((a, b) => a.deadline.compareTo(b.deadline));
      
      state = state.copyWith(
        obligations: obligations,
        isLoading: false,
        overallRiskScore: _calculateRiskScore(obligations),
      );
    } catch (e) {
      state = state.copyWith(isLoading: false);
      debugPrint('Error loading obligations: $e');
    }
  }

  Future<void> addObligation(ObligationModel obligation) async {
    await _repository.addObligation(obligation);
    await loadObligations(); // Güncel listeyi ve yeni skoru almak için tekrar yükle
  }

  Future<void> deleteObligation(String id) async {
    await _repository.deleteObligation(id);
    await loadObligations();
  }
  
  Future<void> markAsPaid(String id) async {
    final obligations = await _repository.getObligations();
    final target = obligations.firstWhere((o) => o.id == id);
    
    final updated = ObligationModel(
      id: target.id,
      userId: target.userId,
      title: target.title,
      category: target.category,
      amount: target.amount,
      deadline: target.deadline,
      isPaid: true,
      riskScore: target.riskScore,
      createdAt: target.createdAt,
      documentUrl: target.documentUrl,
    );
    
    await _repository.addObligation(updated); // putSync olduğu için üzerine yazar
    await loadObligations();
  }

  int _calculateRiskScore(List<ObligationModel> obligations) {
    if (obligations.isEmpty) return 0; // Hiç belge yoksa risk 0 (Harika)
    
    final now = DateTime.now();
    int score = 0;
    
    for (var obs in obligations) {
      if (obs.isPaid) continue; // Ödenenlerin riski yok
      
      final daysLeft = obs.deadline.difference(now).inDays;
      if (daysLeft < 0) {
        score += 40; // Gecikmiş olanlar çok riskli
      } else if (daysLeft <= 3) {
        score += 20; // 3 günden az kalanlar (Kritik)
      } else if (daysLeft <= 7) {
        score += 10; // 1 haftadan az kalanlar
      } else if (daysLeft <= 15) {
        score += 5;
      }
    }
    
    return score > 100 ? 100 : score;
  }
}

final obligationProvider = StateNotifierProvider<ObligationNotifier, ObligationState>((ref) {
  final repository = ref.watch(obligationRepositoryProvider);
  return ObligationNotifier(repository);
});

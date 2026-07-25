class ObligationModel {
  final String id;
  final String userId;
  final String title;
  final String category; // Fatura, Abonelik, Garanti, Sağlık vs.
  final double amount;
  final DateTime deadline;
  final bool isPaid;
  final int riskScore; // 0-100 arası yapay zekanın atadığı risk puanı
  final DateTime createdAt;
  final String? documentUrl; // Taranan belgenin Storage linki

  ObligationModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.category,
    required this.amount,
    required this.deadline,
    this.isPaid = false,
    required this.riskScore,
    required this.createdAt,
    this.documentUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'category': category,
      'amount': amount,
      'deadline': deadline.toIso8601String(),
      'isPaid': isPaid,
      'riskScore': riskScore,
      'createdAt': createdAt.toIso8601String(),
      'documentUrl': documentUrl,
    };
  }

  factory ObligationModel.fromMap(Map<String, dynamic> map) {
    return ObligationModel(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      title: map['title'] ?? '',
      category: map['category'] ?? '',
      amount: map['amount']?.toDouble() ?? 0.0,
      deadline: DateTime.parse(map['deadline']),
      isPaid: map['isPaid'] ?? false,
      riskScore: map['riskScore']?.toInt() ?? 0,
      createdAt: DateTime.parse(map['createdAt']),
      documentUrl: map['documentUrl'],
    );
  }
}

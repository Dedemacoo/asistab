import 'package:isar/isar.dart';

part 'local_obligation.g.dart';

@collection
class LocalObligation {
  Id id = Isar.autoIncrement; // Isar's internal ID

  @Index(unique: true, replace: true)
  late String uuid; // Global unique ID (mapped to ObligationModel.id)

  late String userId;

  late String title;

  late String category;

  late double amount;

  late DateTime deadline;

  bool isPaid = false;

  int riskScore = 0;

  late DateTime createdAt;

  String? documentUrl;
}

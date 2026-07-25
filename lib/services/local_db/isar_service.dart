import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import '../../features/obligations/data/local_obligation.dart';
import '../../features/profile/data/local_user.dart';

class IsarService {
  late Future<Isar> db;

  IsarService() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      if (kIsWeb) {
        return await Isar.open(
          [
            LocalObligationSchema,
            LocalUserSchema,
          ],
          directory: '', // Web'te klasör aranmaz ama parametre olarak verilmesi zorunludur
          inspector: true,
        );
      } else {
        final dir = await getApplicationDocumentsDirectory();
        return await Isar.open(
          [
            LocalObligationSchema,
            LocalUserSchema,
          ],
          directory: dir.path,
          inspector: true,
        );
      }
    }
    
    return Future.value(Isar.getInstance());
  }

  // Yükümlülük Ekleme / Güncelleme
  Future<void> saveObligation(LocalObligation obligation) async {
    final isar = await db;
    isar.writeTxnSync(() => isar.localObligations.putSync(obligation));
  }

  // Tüm Yükümlülükleri Getirme
  Future<List<LocalObligation>> getAllObligations() async {
    final isar = await db;
    return await isar.localObligations.where().findAll();
  }

  // Yükümlülük Silme
  Future<void> deleteObligation(String uuid) async {
    final isar = await db;
    isar.writeTxnSync(() {
      isar.localObligations.where().uuidEqualTo(uuid).deleteAllSync();
    });
  }

  // Kullanıcı (LocalUser) İşlemleri
  Future<void> saveUser(LocalUser user) async {
    final isar = await db;
    isar.writeTxnSync(() => isar.localUsers.putSync(user));
  }

  Future<LocalUser?> getUser() async {
    final isar = await db;
    return await isar.localUsers.where().findFirst();
  }
}

final isarServiceProvider = Provider<IsarService>((ref) {
  return IsarService();
});

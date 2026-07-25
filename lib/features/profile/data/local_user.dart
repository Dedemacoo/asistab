import 'package:isar/isar.dart';

part 'local_user.g.dart';

@collection
class LocalUser {
  Id id = Isar.autoIncrement;

  String? name;
  String? surname;
  String? email;
  String? profilePicturePath; // Can be a local path or base64 string on Web
  
  bool isFaceIdEnabled = false;
  String? geminiApiKey;
  String? selectedCity; // Kullanıcının seçtiği veya GPS'ten bulunan şehir

  // Kurum Entegrasyonları için (Simülasyon)
  List<String> connectedInstitutions = []; 
}

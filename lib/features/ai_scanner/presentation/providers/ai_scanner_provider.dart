import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/ai_scanner_service.dart';
import '../../../profile/presentation/providers/user_provider.dart';

final aiScannerServiceProvider = Provider<AiScannerService?>((ref) {
  final user = ref.watch(userProvider);
  String? apiKey = user?.geminiApiKey;
  
  // Eğer kullanıcı profilde bir key girmemişse varsayılan keyi kullan
  if (apiKey == null || apiKey.isEmpty) {
    apiKey = 'YOUR_API_KEY_HERE';
  }
  
  return AiScannerService(apiKey);
});

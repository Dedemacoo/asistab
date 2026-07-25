import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';

class AiScannerService {
  final String apiKey;
  
  AiScannerService(this.apiKey);

  Future<Map<String, dynamic>?> scanDocument(XFile imageFile) async {
    if (apiKey.isEmpty) {
      throw Exception('Lütfen Ayarlar sayfasından Gemini API Anahtarınızı girin.');
    }

    try {
      final model = GenerativeModel(
        model: 'gemini-1.5-flash',
        apiKey: apiKey,
      );

      final imageBytes = await imageFile.readAsBytes();
      final prompt = TextPart('''
Bu resmi analiz et ve içindeki belgenin (fatura, ceza, garanti belgesi vb.) verilerini JSON formatında dön. SADECE JSON formatında cevap ver, başka bir açıklama ekleme. Eğer resim bir belge değilse veya okunamıyorsa null dön.

Çıkarman gereken JSON formatı:
{
  "title": "Belgenin kısa bir başlığı (örn: İGDAŞ Doğalgaz Faturası)",
  "category": "Garanti, Taşıt, Sağlık, Abonelik, Fatura kategorilerinden en uygun olanı",
  "amount": "Tutar (Sadece sayısal değer, örn: 154.50)",
  "deadline": "Son ödeme tarihi veya garanti bitiş tarihi (ISO 8601 formatında YYYY-MM-DD)"
}
''');
      
      final imageParts = [
        DataPart('image/jpeg', imageBytes),
      ];

      final response = await model.generateContent([
        Content.multi([prompt, ...imageParts])
      ]);
      
      final text = response.text ?? '';
      
      // Extract JSON from response (in case it includes markdown code blocks)
      String jsonString = text;
      if (text.contains('```json')) {
        jsonString = text.split('```json')[1].split('```')[0].trim();
      } else if (text.contains('```')) {
        jsonString = text.split('```')[1].split('```')[0].trim();
      }
      
      final Map<String, dynamic> data = jsonDecode(jsonString);
      return data;
    } catch (e) {
      debugPrint('AI Scanner Error: $e');
      throw Exception('Belge okunamadı. Lütfen fotoğrafın net olduğundan emin olun.');
    }
  }
}

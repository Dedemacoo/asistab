import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/ai_scanner_provider.dart';
import '../../obligations/presentation/widgets/add_obligation_bottom_sheet.dart';
import '../../obligations/domain/obligation_model.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';

class AiScannerHelper {
  static Future<void> showScannerOptions(BuildContext context, WidgetRef ref) async {
    final aiService = ref.read(aiScannerServiceProvider);
    
    if (aiService == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Lütfen Profil > Ayarlar kısmından Gemini API Anahtarınızı girin.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final picker = ImagePicker();
    
    // Alt pencere ile Kamera / Galeri seçimi
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => GlassContainer(
        height: 200,
        blur: 15,
        color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.8),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(2))),
            const SizedBox(height: 24),
            Text('Yapay Zeka Fatura Tarayıcı', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildOptionBtn(context, Icons.camera_alt, 'Kamera', () => Navigator.pop(context, ImageSource.camera)),
                _buildOptionBtn(context, Icons.photo_library, 'Galeri', () => Navigator.pop(context, ImageSource.gallery)),
              ],
            ),
          ],
        ),
      ),
    );

    if (source == null) return;

    final XFile? image = await picker.pickImage(source: source);
    if (image == null) return;

    // Loading Dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Yapay Zeka Belgeyi Okuyor...', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold, decoration: TextDecoration.none)),
          ],
        ),
      ),
    );

    try {
      final data = await aiService.scanDocument(image);
      Navigator.pop(context); // Close loading
      
      if (data == null) {
        throw Exception('Belge tanınamadı.');
      }

      // Parse data
      final title = data['title']?.toString() ?? '';
      final category = data['category']?.toString() ?? 'Fatura';
      
      double amount = 0.0;
      if (data['amount'] != null) {
        amount = double.tryParse(data['amount'].toString()) ?? 0.0;
      }
      
      DateTime deadline = DateTime.now();
      if (data['deadline'] != null) {
        deadline = DateTime.tryParse(data['deadline'].toString()) ?? DateTime.now();
      }

      // Pre-filled modeli oluştur
      final prefilledObligation = ObligationModel(
        id: '',
        userId: 'temp',
        title: title,
        category: category,
        amount: amount,
        deadline: deadline,
        riskScore: 0,
        createdAt: DateTime.now(),
      );

      // AddObligationBottomSheet'i ön dolu olarak aç
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => AddObligationBottomSheet(prefilledObligation: prefilledObligation),
      );

    } catch (e) {
      Navigator.pop(context); // Close loading
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  static Widget _buildOptionBtn(BuildContext context, IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            child: Icon(icon, size: 30, color: Theme.of(context).colorScheme.primary),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

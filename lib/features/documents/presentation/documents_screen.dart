import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../obligations/presentation/providers/obligation_provider.dart';

class DocumentsScreen extends ConsumerWidget {
  const DocumentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final obligationState = ref.watch(obligationProvider);
    final obligations = obligationState.obligations;
    
    // İşlemleri kategorilerine göre grupla
    final Map<String, int> categoryCounts = {};
    for (var obs in obligations) {
      categoryCounts[obs.category] = (categoryCounts[obs.category] ?? 0) + 1;
    }

    // Gösterilecek sabit kategoriler (Veritabanındaki dropdown ile eşleşmeli)
    final defaultCategories = [
      {'title': 'Fatura', 'icon': Icons.electrical_services},
      {'title': 'Garanti', 'icon': Icons.security},
      {'title': 'Taşıt', 'icon': Icons.directions_car},
      {'title': 'Sağlık', 'icon': Icons.local_hospital},
      {'title': 'Abonelik', 'icon': Icons.subscriptions},
      {'title': 'Diğer', 'icon': Icons.receipt},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Belgeler')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: obligationState.isLoading 
            ? const Center(child: CircularProgressIndicator())
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.2,
                ),
                itemCount: defaultCategories.length,
                itemBuilder: (context, index) {
                  final cat = defaultCategories[index];
                  final title = cat['title'] as String;
                  final icon = cat['icon'] as IconData;
                  final count = categoryCounts[title] ?? 0;
                  
                  return Card(
                    child: InkWell(
                      onTap: () {
                        // Gelecekte buraya tıklandığında sadece o kategoriye ait belgelerin listeleneceği sayfa açılacak
                      },
                      borderRadius: BorderRadius.circular(24),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(icon, size: 32, color: Theme.of(context).colorScheme.primary),
                            const Spacer(),
                            Text(
                              title,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '$count İşlem/Belge',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ).animate().fadeIn(delay: (80 * index).ms, duration: 400.ms).slideY(begin: 0.1);
                },
              ),
        ),
      ),
    );
  }
}

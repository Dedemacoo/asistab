import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/user_provider.dart';

class SecurityScreen extends ConsumerStatefulWidget {
  const SecurityScreen({super.key});

  @override
  ConsumerState<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends ConsumerState<SecurityScreen> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    final isFaceIdEnabled = user?.isFaceIdEnabled ?? false;

    return Scaffold(
      appBar: AppBar(title: const Text('PIN ve FaceID')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Bilgi kartı
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(Icons.shield_outlined, color: Theme.of(context).colorScheme.primary, size: 32),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Biyometrik Güvenlik', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        SizedBox(height: 4),
                        Text('Uygulamayı açarken yüz tanıma veya parmak izi ile kimlik doğrulama yapabilirsiniz.',
                            style: TextStyle(fontSize: 13, height: 1.4)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Column(
              children: [
                SwitchListTile(
                  title: const Text('Biyometrik Giriş', style: TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: Text(
                    kIsWeb
                        ? 'Web tarayıcıda biyometrik doğrulama desteklenmiyor. Mobil uygulamayı kullanın.'
                        : 'FaceID / Parmak İzi ile uygulamaya giriş',
                  ),
                  value: isFaceIdEnabled,
                  secondary: Icon(
                    isFaceIdEnabled ? Icons.face : Icons.face_outlined,
                    color: isFaceIdEnabled ? Theme.of(context).colorScheme.primary : Colors.grey,
                  ),
                  onChanged: kIsWeb
                      ? null // Web'de devre dışı
                      : (val) async {
                          ref.read(userProvider.notifier).updateUser(isFaceIdEnabled: val);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(val ? '✅ Biyometrik giriş etkinleştirildi' : 'Biyometrik giriş devre dışı'),
                              backgroundColor: val ? Colors.green : Colors.orange,
                            ),
                          );
                        },
                ),
              ],
            ),
          ),
          if (kIsWeb) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.orange.withOpacity(0.3)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.orange, size: 20),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Biyometrik doğrulama yalnızca Android ve iOS uygulamasında kullanılabilir.',
                      style: TextStyle(color: Colors.orange, fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

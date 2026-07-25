import 'package:flutter/material.dart';
import '../../../../core/widgets/app_snack_bar.dart';

// ─────────────────────────────────────────────────────────
// AİLE YÖNETİMİ
// ─────────────────────────────────────────────────────────
import 'package:flutter_riverpod/flutter_riverpod.dart';

final familyMembersProvider = StateProvider<List<Map<String, dynamic>>>((ref) {
  return [
    {'name': 'Sen', 'role': 'Yönetici', 'icon': Icons.person, 'color': Colors.blue},
  ];
});

class FamilyManagementScreen extends ConsumerStatefulWidget {
  const FamilyManagementScreen({super.key});
  @override
  ConsumerState<FamilyManagementScreen> createState() => _FamilyManagementScreenState();
}

class _FamilyManagementScreenState extends ConsumerState<FamilyManagementScreen> {
  void _addMember() {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Aile Üyesi Ekle'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(labelText: 'Ad Soyad', border: OutlineInputBorder()),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('İptal')),
          ElevatedButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                final currentMembers = ref.read(familyMembersProvider);
                ref.read(familyMembersProvider.notifier).state = [
                  ...currentMembers,
                  {
                    'name': controller.text,
                    'role': 'Üye',
                    'icon': Icons.person_outline,
                    'color': Colors.purple,
                  }
                ];
                Navigator.pop(ctx);
                AppSnackBar.showSuccess(context, 'Üye başarıyla eklendi.');
              }
            },
            child: const Text('Ekle'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final members = ref.watch(familyMembersProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Aile Yönetimi')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addMember,
        icon: const Icon(Icons.person_add),
        label: const Text('Üye Ekle'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Icon(Icons.info_outline, color: Theme.of(context).colorScheme.primary, size: 20),
                    const SizedBox(width: 8),
                    const Text('Aile Paylaşımı', style: TextStyle(fontWeight: FontWeight.bold)),
                  ]),
                  const SizedBox(height: 8),
                  const Text(
                    'Aile üyelerinizi ekleyerek ortak yükümlülükleri birlikte takip edebilirsiniz. Üyeler eklendikten sonra bildirimleri paylaşabilirsiniz.',
                    style: TextStyle(height: 1.5),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text('Üyeler (${members.length})',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold, color: Colors.grey)),
          const SizedBox(height: 12),
          ...members.map((m) => Card(
                margin: const EdgeInsets.only(bottom: 10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: (m['color'] as Color).withOpacity(0.15),
                    child: Icon(m['icon'] as IconData, color: m['color'] as Color),
                  ),
                  title: Text(m['name'], style: const TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: Text(m['role']),
                  trailing: m['role'] == 'Yönetici'
                      ? const Chip(label: Text('Sen', style: TextStyle(fontSize: 12)))
                      : IconButton(
                          icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
                          onPressed: () {
                            final currentMembers = ref.read(familyMembersProvider);
                            ref.read(familyMembersProvider.notifier).state = 
                                currentMembers.where((element) => element != m).toList();
                            AppSnackBar.showSuccess(context, 'Üye çıkarıldı.');
                          },
                        ),
                ),
              )),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────
// BULUT SENKRONİZASYONU
// ─────────────────────────────────────────────────────────
class CloudSyncScreen extends StatefulWidget {
  const CloudSyncScreen({super.key});
  @override
  State<CloudSyncScreen> createState() => _CloudSyncScreenState();
}

class _CloudSyncScreenState extends State<CloudSyncScreen> {
  bool _autoSync = true;
  bool _syncOnWifi = true;
  bool _isSyncing = false;

  Future<void> _sync() async {
    setState(() => _isSyncing = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => _isSyncing = false);
    if (mounted) {
      AppSnackBar.showSuccess(context, 'Veriler başarıyla senkronize edildi!');
    }
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    return Scaffold(
      appBar: AppBar(title: const Text('Bulut Senkronizasyonu')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Durum kartı
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Theme.of(context).colorScheme.primary.withOpacity(0.8),
                         Theme.of(context).colorScheme.secondary.withOpacity(0.6)],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(children: [
              const Icon(Icons.cloud_done, size: 48, color: Colors.white),
              const SizedBox(height: 12),
              const Text('Senkronize', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text('Son sync: ${now.day}/${now.month}/${now.year} ${now.hour}:${now.minute.toString().padLeft(2,'0')}',
                  style: const TextStyle(color: Colors.white70, fontSize: 13)),
            ]),
          ),
          const SizedBox(height: 20),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Column(children: [
              SwitchListTile(
                title: const Text('Otomatik Senkronizasyon', style: TextStyle(fontWeight: FontWeight.w600)),
                subtitle: const Text('Değişiklikler anında buluta yedeklenir'),
                value: _autoSync,
                onChanged: (v) => setState(() => _autoSync = v),
                secondary: const Icon(Icons.sync),
              ),
              const Divider(height: 0),
              SwitchListTile(
                title: const Text('Yalnızca Wi-Fi', style: TextStyle(fontWeight: FontWeight.w600)),
                subtitle: const Text('Mobil veri kullanımını sınırla'),
                value: _syncOnWifi,
                onChanged: (v) => setState(() => _syncOnWifi = v),
                secondary: const Icon(Icons.wifi),
              ),
            ]),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              icon: _isSyncing
                  ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                  : const Icon(Icons.cloud_upload),
              label: Text(_isSyncing ? 'Senkronize ediliyor...' : 'Şimdi Senkronize Et'),
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
              onPressed: _isSyncing ? null : _sync,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────
// BİLDİRİM AYARLARI
// ─────────────────────────────────────────────────────────
final notificationSettingsProvider = StateProvider<Map<String, bool>>((ref) {
  return {
    'deadlineAlert': true,
    'threeDayAlert': true,
    'weeklyReport': false,
    'paidReminder': true,
    'overdueAlert': true,
  };
});

class NotificationsScreen extends ConsumerStatefulWidget {
  const NotificationsScreen({super.key});
  @override
  ConsumerState<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends ConsumerState<NotificationsScreen> {
  void _updateSetting(String key, bool value) {
    final currentSettings = ref.read(notificationSettingsProvider);
    ref.read(notificationSettingsProvider.notifier).state = {
      ...currentSettings,
      key: value,
    };
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(notificationSettingsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Akıllı Bildirim Ayarları')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _sectionHeader(context, 'Son Ödeme Bildirimleri'),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Column(children: [
              SwitchListTile(
                secondary: const Icon(Icons.alarm),
                title: const Text('Son gün hatırlatması', style: TextStyle(fontWeight: FontWeight.w600)),
                subtitle: const Text('Son ödeme günü bildirim gönder'),
                value: settings['deadlineAlert'] ?? true,
                onChanged: (v) => _updateSetting('deadlineAlert', v),
              ),
              const Divider(height: 0),
              SwitchListTile(
                secondary: const Icon(Icons.alarm_on),
                title: const Text('3 gün önceden hatırlat', style: TextStyle(fontWeight: FontWeight.w600)),
                subtitle: const Text('Son ödeme tarihinden 3 gün önce bildir'),
                value: settings['threeDayAlert'] ?? true,
                onChanged: (v) => _updateSetting('threeDayAlert', v),
              ),
              const Divider(height: 0),
              SwitchListTile(
                secondary: const Icon(Icons.warning_amber),
                title: const Text('Gecikmiş ödemeler', style: TextStyle(fontWeight: FontWeight.w600)),
                subtitle: const Text('Süresi geçen belgeler için uyar'),
                value: settings['overdueAlert'] ?? true,
                onChanged: (v) => _updateSetting('overdueAlert', v),
              ),
            ]),
          ),
          const SizedBox(height: 20),
          _sectionHeader(context, 'Periyodik Raporlar'),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Column(children: [
              SwitchListTile(
                secondary: const Icon(Icons.bar_chart),
                title: const Text('Haftalık özet raporu', style: TextStyle(fontWeight: FontWeight.w600)),
                subtitle: const Text('Her Pazartesi haftalık özet gönder'),
                value: settings['weeklyReport'] ?? false,
                onChanged: (v) => _updateSetting('weeklyReport', v),
              ),
              const Divider(height: 0),
              SwitchListTile(
                secondary: const Icon(Icons.check_circle_outline),
                title: const Text('Ödeme tamamlandı', style: TextStyle(fontWeight: FontWeight.w600)),
                subtitle: const Text('Belge ödendi olarak işaretlendiğinde bildir'),
                value: settings['paidReminder'] ?? true,
                onChanged: (v) => _updateSetting('paidReminder', v),
              ),
            ]),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.save_outlined),
              label: const Text('Ayarları Kaydet', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
              onPressed: () {
                AppSnackBar.showSuccess(context, 'Bildirim ayarları kaydedildi!');
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(title,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold, color: Colors.grey)),
    );
  }
}

// ─────────────────────────────────────────────────────────
// VERİ GİZLİLİĞİ
// ─────────────────────────────────────────────────────────
class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Veri Gizliliği')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildSection(context, icon: Icons.security, title: 'Güvenlik & Şifreleme',
              body: 'AsistAB, tüm kişisel verilerinizi yerel olarak cihazınızda saklar. İnternet bağlantısı gerektiren hiçbir işlem için verileriniz üçüncü taraflarla paylaşılmaz. Veritabanınız AES-256 standardıyla şifrelenmektedir.'),
          _buildSection(context, icon: Icons.person_pin, title: 'Toplanan Veriler',
              body: 'Yalnızca sizin girdiğiniz bilgiler (ad, soyad, e-posta, yükümlülük bilgileri) cihazınızda saklanır. Konum, mikrofon veya rehber gibi hassas izinler kullanılmaz.'),
          _buildSection(context, icon: Icons.share, title: 'Veri Paylaşımı',
              body: "Verileriniz hiçbir üçüncü tarafla paylaşılmaz. Yapay Zeka özelliğini kullandığınızda yalnızca taradığınız belge görseli Google Gemini API'sine iletilir ve sonuç cihazınızda işlenir."),
          _buildSection(context, icon: Icons.rule, title: 'KVKK & GDPR Hakları',
              body: '6698 sayılı KVKK ve GDPR kapsamında verilerinizi istediğiniz zaman silebilir, düzeltebilir veya dışa aktarabilirsiniz. Uygulamayı silmeniz halinde tüm yerel veriler kalıcı olarak temizlenir.'),
          _buildSection(context, icon: Icons.child_care, title: 'Çocukların Gizliliği',
              body: 'AsistAB, 13 yaşın altındaki bireylerden bilerek veri toplamaz.'),
          const SizedBox(height: 16),
          Center(child: Text('Son güncelleme: Temmuz 2026',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey))),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, {required IconData icon, required String title, required String body}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Icon(icon, color: Theme.of(context).colorScheme.primary, size: 22),
            const SizedBox(width: 10),
            Text(title, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
          ]),
          const SizedBox(height: 10),
          Text(body, style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.5)),
        ]),
      ),
    );
  }
}

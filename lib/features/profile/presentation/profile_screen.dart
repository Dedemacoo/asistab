import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:image_picker/image_picker.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/app_snack_bar.dart';
import 'providers/user_provider.dart';
import 'screens/personal_info_screen.dart';
import 'screens/security_screen.dart';
import 'screens/integrations_screen.dart';
import 'screens/smart_notifications_screen.dart';
import 'screens/placeholder_screens.dart';
import '../../auth/presentation/auth_screen.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final user = ref.watch(userProvider);
    final isDark = themeMode == ThemeMode.dark || 
                  (themeMode == ThemeMode.system && MediaQuery.of(context).platformBrightness == Brightness.dark);

    final bool isLoggedIn = user?.email != null && user!.email!.isNotEmpty;
    final String displayName = (user?.name != null && user!.name!.isNotEmpty) ? '${user.name} ${user.surname ?? ''}' : 'Kullanıcı';

    return Scaffold(
      appBar: AppBar(title: const Text('Profil & Ayarlar')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24.0),
          physics: const BouncingScrollPhysics(),
          children: [
            if (!isLoggedIn) ...[
              // Giriş Yap CTA Kartı
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const AuthScreen()));
                },
                child: GlassContainer(
                  blur: 20,
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  border: Border.fromBorderSide(BorderSide(color: Theme.of(context).colorScheme.primary.withOpacity(0.3))),
                  borderRadius: BorderRadius.circular(24),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.person_outline, size: 30, color: Theme.of(context).colorScheme.primary),
                        ),
                        const SizedBox(width: 16),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Hesap Oluştur / Giriş Yap', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                              SizedBox(height: 4),
                              Text('Verilerinizi yedeklemek ve cihazlar arası eşitlemek için giriş yapın.', style: TextStyle(fontSize: 12, color: Colors.grey)),
                            ],
                          ),
                        ),
                        const Icon(Icons.chevron_right),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ] else ...[
              // Profil Bilgileri
              GestureDetector(
                onTap: () async {
                  final picker = ImagePicker();
                  final image = await picker.pickImage(
                    source: ImageSource.gallery,
                    imageQuality: 80,
                  );
                  if (image != null) {
                    ref.read(userProvider.notifier).updateUser(profilePicturePath: image.path);
                  }
                },
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                      backgroundImage: (user?.profilePicturePath != null && user!.profilePicturePath!.isNotEmpty)
                          ? NetworkImage(user.profilePicturePath!)
                          : null,
                      child: (user?.profilePicturePath == null || user!.profilePicturePath!.isEmpty)
                          ? Icon(Icons.person, size: 50, color: Theme.of(context).colorScheme.primary)
                          : null,
                    ),
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      child: const Icon(Icons.camera_alt, size: 16, color: Colors.white),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                displayName,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              if (user?.email != null) ...[
                const SizedBox(height: 4),
                Text(
                  user!.email!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
              const SizedBox(height: 32),
            ],
            _buildSettingsGroup(
              context,
              'Hesap',
              [
                _buildSettingsTile(context, Icons.person, 'Kişisel Bilgiler', onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const PersonalInfoScreen()));
                }),
                _buildSettingsTile(context, Icons.account_balance, 'Kurum Entegrasyonları', onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const IntegrationsScreen()));
                }),
                _buildSettingsTile(context, Icons.family_restroom, 'Aile Yönetimi', onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const FamilyManagementScreen()));
                }),
                _buildSettingsTile(context, Icons.cloud_sync, 'Bulut Senkronizasyonu', onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const CloudSyncScreen()));
                }),
              ],
            ),
            const SizedBox(height: 24),
            _buildSettingsGroup(
              context,
              'Güvenlik',
              [
                _buildSettingsTile(context, Icons.lock, 'PIN ve FaceID Ayarları', onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const SecurityScreen()));
                }),
                _buildSettingsTile(context, Icons.privacy_tip, 'Veri Gizliliği (KVKK/GDPR)', onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const PrivacyScreen()));
                }),
              ],
            ),
            const SizedBox(height: 24),
            _buildSettingsGroup(
              context,
              'Görünüm ve Bildirimler',
              [
                ListTile(
                  leading: Icon(isDark ? Icons.light_mode : Icons.dark_mode, color: Theme.of(context).colorScheme.primary),
                  title: Text(isDark ? 'Açık Mod' : 'Karanlık Mod', style: const TextStyle(fontWeight: FontWeight.w500)),
                  trailing: Switch(
                    value: isDark,
                    onChanged: (val) {
                      ref.read(themeProvider.notifier).state = val ? ThemeMode.dark : ThemeMode.light;
                    },
                  ),
                ),
                _buildSettingsTile(context, Icons.notifications_active, 'Akıllı Bildirim Ayarları', onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const SmartNotificationsScreen()));
                }),
              ],
            ),
            if (isLoggedIn) ...[
              const SizedBox(height: 32),
              OutlinedButton.icon(
                onPressed: () {
                  ref.read(userProvider.notifier).logout();
                  AppSnackBar.showInfo(context, 'Başarıyla çıkış yapıldı.');
                },
                icon: const Icon(Icons.logout, color: Colors.red),
                label: const Text('Hesaptan Çıkış Yap', style: TextStyle(color: Colors.red)),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.red),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ],
            const SizedBox(height: 80), // Fab için boşluk
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsGroup(BuildContext context, String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Card(
          child: Column(
            children: children,
          ),
        ),
      ],
    ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.05);
  }

  Widget _buildSettingsTile(BuildContext context, IconData icon, String title, {VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      trailing: const Icon(Icons.chevron_right, size: 20),
      onTap: onTap ?? () {},
    );
  }
}

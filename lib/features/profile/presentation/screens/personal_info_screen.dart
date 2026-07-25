import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:asistab/core/widgets/app_snack_bar.dart';
import '../providers/user_provider.dart';
import '../../../auth/presentation/auth_screen.dart';

class PersonalInfoScreen extends ConsumerStatefulWidget {
  final bool showWelcomeToast;
  const PersonalInfoScreen({super.key, this.showWelcomeToast = false});

  @override
  ConsumerState<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends ConsumerState<PersonalInfoScreen> {
  late TextEditingController _nameController;
  late TextEditingController _surnameController;
  late TextEditingController _emailController;
  late TextEditingController _cityController;

  @override
  void initState() {
    super.initState();
    final user = ref.read(userProvider);
    _nameController = TextEditingController(text: user?.name ?? '');
    _surnameController = TextEditingController(text: user?.surname ?? '');
    _emailController = TextEditingController(text: user?.email ?? '');
    _cityController = TextEditingController(text: user?.selectedCity ?? '');

    if (widget.showWelcomeToast) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          final currentUser = ref.read(userProvider);
          final name = (currentUser?.name != null && currentUser!.name!.isNotEmpty) ? currentUser.name! : 'Arjin';
          AppSnackBar.showSuccess(context, 'Hoş geldin $name! Oturum açıldı.');
        }
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    _emailController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    final bool isLoggedIn = user?.email != null && user!.email!.isNotEmpty;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    ref.listen(userProvider, (previous, next) {
      if (next != null && next.email != null) {
        if (_nameController.text.isEmpty && next.name != null) _nameController.text = next.name!;
        if (_surnameController.text.isEmpty && next.surname != null) _surnameController.text = next.surname!;
        if (_emailController.text.isEmpty && next.email != null) _emailController.text = next.email!;
        if (_cityController.text.isEmpty && next.selectedCity != null) _cityController.text = next.selectedCity!;
      }
    });

    if (isLoggedIn) {
      if (_nameController.text.isEmpty && user?.name != null) _nameController.text = user!.name!;
      if (_surnameController.text.isEmpty && user?.surname != null) _surnameController.text = user!.surname!;
      if (_emailController.text.isEmpty && user?.email != null) _emailController.text = user!.email!;
      if (_cityController.text.isEmpty && user?.selectedCity != null) _cityController.text = user!.selectedCity!;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kişisel Bilgiler'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: !isLoggedIn
              ? _buildLoggedOutState(context, isDark)
              : _buildLoggedInForm(context, user, isDark),
        ),
      ),
    );
  }

  Widget _buildLoggedOutState(BuildContext context, bool isDark) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 40),
        Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
          ),
          child: Icon(
            Icons.lock_person_outlined,
            size: 48,
            color: Theme.of(context).colorScheme.primary,
          ),
        ).animate().scale(duration: 400.ms, curve: Curves.easeOutBack),
        const SizedBox(height: 24),
        Text(
          'Oturum Açmanız Gerekiyor',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ).animate().fadeIn(delay: 150.ms),
        const SizedBox(height: 12),
        const Text(
          'Kişisel bilgilerinizi görüntülemek, düzenlemek ve bulut yedeklemeyi aktif etmek için lütfen giriş yapın.',
          style: TextStyle(color: Colors.grey, height: 1.5),
          textAlign: TextAlign.center,
        ).animate().fadeIn(delay: 250.ms),
        const SizedBox(height: 36),
        GlassContainer(
          blur: 20,
          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
          border: Border.fromBorderSide(
            BorderSide(color: Theme.of(context).colorScheme.primary.withOpacity(0.3)),
          ),
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const AuthScreen()));
                },
                icon: const Icon(Icons.login_rounded),
                label: const Text('Giriş Yap / Hesap Oluştur', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
              ),
            ),
          ),
        ).animate().slideY(begin: 0.1, delay: 350.ms).fadeIn(),
      ],
    );
  }

  Widget _buildLoggedInForm(BuildContext context, user, bool isDark) {
    return Column(
      children: [
        // Profil Rozeti ve Durum
        GlassContainer(
          blur: 20,
          color: isDark ? Colors.white.withOpacity(0.04) : Colors.black.withOpacity(0.02),
          border: Border.fromBorderSide(
            BorderSide(color: Theme.of(context).colorScheme.primary.withOpacity(0.2)),
          ),
          borderRadius: BorderRadius.circular(24),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                  backgroundImage: (user?.profilePicturePath != null && user!.profilePicturePath!.isNotEmpty)
                      ? NetworkImage(user.profilePicturePath!)
                      : null,
                  child: (user?.profilePicturePath == null || user!.profilePicturePath!.isEmpty)
                      ? Icon(Icons.person, size: 36, color: Theme.of(context).colorScheme.primary)
                      : null,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${user?.name ?? ''} ${user?.surname ?? ''}'.trim().isEmpty ? 'Kullanıcı' : '${user?.name ?? ''} ${user?.surname ?? ''}',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.verified_user_rounded, size: 16, color: Colors.green),
                          const SizedBox(width: 4),
                          Text(
                            'Aktif Oturum',
                            style: TextStyle(fontSize: 12, color: Colors.green.shade600, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.1),

        const SizedBox(height: 24),

        // Bilgi Düzenleme Kartı
        GlassContainer(
          blur: 20,
          color: isDark ? Colors.white.withOpacity(0.03) : Colors.black.withOpacity(0.02),
          border: Border.fromBorderSide(
            BorderSide(color: isDark ? Colors.white10 : Colors.black12),
          ),
          borderRadius: BorderRadius.circular(24),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Profil Bilgileri',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),

                _buildStyledTextField(
                  controller: _nameController,
                  label: 'Ad',
                  icon: Icons.person_outline,
                ),
                const SizedBox(height: 16),

                _buildStyledTextField(
                  controller: _surnameController,
                  label: 'Soyad',
                  icon: Icons.badge_outlined,
                ),
                const SizedBox(height: 16),

                _buildStyledTextField(
                  controller: _emailController,
                  label: 'E-posta Adresi',
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  readOnly: true, // E-posta oturum sağlayıcıdan geldiği için salt okunur
                  suffixWidget: const Icon(Icons.lock_outline, size: 16, color: Colors.grey),
                ),
                const SizedBox(height: 16),

                _buildStyledTextField(
                  controller: _cityController,
                  label: 'İl / Konum',
                  icon: Icons.location_on_outlined,
                ),
                const SizedBox(height: 28),

                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      ref.read(userProvider.notifier).updateUser(
                            name: _nameController.text.trim(),
                            surname: _surnameController.text.trim(),
                            selectedCity: _cityController.text.trim().isEmpty ? null : _cityController.text.trim(),
                          );
                      AppSnackBar.showSuccess(context, 'Kişisel bilgileriniz güncellendi!');
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.save_rounded),
                    label: const Text('Bilgileri Kaydet', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Colors.white,
                      elevation: 4,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1),
      ],
    );
  }

  Widget _buildStyledTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    bool readOnly = false,
    Widget? suffixWidget,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return TextField(
      controller: controller,
      readOnly: readOnly,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Theme.of(context).colorScheme.primary),
        suffixIcon: suffixWidget,
        filled: true,
        fillColor: isDark ? Colors.white.withOpacity(0.05) : Colors.black.withOpacity(0.04),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: isDark ? Colors.white10 : Colors.black.withOpacity(0.05)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
        ),
      ),
    );
  }
}

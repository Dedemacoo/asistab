import 'package:flutter/material.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/widgets/app_snack_bar.dart';

class SmartNotificationsScreen extends StatefulWidget {
  const SmartNotificationsScreen({super.key});

  @override
  State<SmartNotificationsScreen> createState() => _SmartNotificationsScreenState();
}

class _SmartNotificationsScreenState extends State<SmartNotificationsScreen> {
  bool _deadlineAlert = true;
  bool _threeDayAlert = true;
  bool _aiRiskAlert = true;
  bool _weeklyReport = true;
  bool _institutionBills = true;
  bool _quietHours = true;
  bool _vibration = true;

  String _soundPreference = 'AsistAB Özel Ses';
  final List<String> _soundOptions = ['AsistAB Özel Ses', 'Varsayılan', 'Sessiz'];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Akıllı Bildirim Ayarları'),
        elevation: 0,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          physics: const BouncingScrollPhysics(),
          children: [
            // Banner Card
            GlassContainer(
              blur: 20,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              border: Border.fromBorderSide(
                BorderSide(color: Theme.of(context).colorScheme.primary.withOpacity(0.3)),
              ),
              borderRadius: BorderRadius.circular(20),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.auto_awesome,
                        color: Theme.of(context).colorScheme.primary,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Yapay Zeka Destekli Bildirimler',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'AsistAB, son ödeme günlerini ve risk puanını analiz ederek kritik zamanlarda uyarı gönderir.',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.1),

            const SizedBox(height: 24),
            _buildSectionTitle('Otomatik Ödeme & Son Gün Uyarısı'),
            const SizedBox(height: 12),
            _buildCardWrapper(
              isDark,
              children: [
                _buildSwitchTile(
                  icon: Icons.alarm_on_rounded,
                  iconColor: const Color(0xFFEF4444),
                  title: 'Son Gün Hatırlatması',
                  subtitle: 'Son ödeme gününde saat 09:00\'da yüksek öncelikli bildirim gönder',
                  value: _deadlineAlert,
                  onChanged: (v) => setState(() => _deadlineAlert = v),
                ),
                const Divider(height: 1, indent: 60),
                _buildSwitchTile(
                  icon: Icons.calendar_month_rounded,
                  iconColor: const Color(0xFF3B82F6),
                  title: 'Erken Uyarı (3 Gün Önce)',
                  subtitle: 'Son ödeme tarihinden 3 gün önce hatırlat',
                  value: _threeDayAlert,
                  onChanged: (v) => setState(() => _threeDayAlert = v),
                ),
                const Divider(height: 1, indent: 60),
                _buildSwitchTile(
                  icon: Icons.receipt_long_rounded,
                  iconColor: const Color(0xFF10B981),
                  title: 'Kurum Faturası Yayınlandı',
                  subtitle: 'Bağlı kurumlarınızdan yeni fatura geldiğinde anında bildir',
                  value: _institutionBills,
                  onChanged: (v) => setState(() => _institutionBills = v),
                ),
              ],
            ),

            const SizedBox(height: 24),
            _buildSectionTitle('AI Risk & Raporlama'),
            const SizedBox(height: 12),
            _buildCardWrapper(
              isDark,
              children: [
                _buildSwitchTile(
                  icon: Icons.security_rounded,
                  iconColor: const Color(0xFFF59E0B),
                  title: 'Yapay Zeka Risk Uyarısı',
                  subtitle: 'Risk puanınız kritik eşiği (40+) aştığında acil durum bildirimi at',
                  value: _aiRiskAlert,
                  onChanged: (v) => setState(() => _aiRiskAlert = v),
                ),
                const Divider(height: 1, indent: 60),
                _buildSwitchTile(
                  icon: Icons.insights_rounded,
                  iconColor: const Color(0xFF8B5CF6),
                  title: 'Haftalık Finansal Özet',
                  subtitle: 'Her Pazartesi sabahı genel risk ve ödeme durumunu raporla',
                  value: _weeklyReport,
                  onChanged: (v) => setState(() => _weeklyReport = v),
                ),
              ],
            ),

            const SizedBox(height: 24),
            _buildSectionTitle('Sessizlik & Ses Ayarları'),
            const SizedBox(height: 12),
            _buildCardWrapper(
              isDark,
              children: [
                _buildSwitchTile(
                  icon: Icons.bedtime_rounded,
                  iconColor: const Color(0xFF6366F1),
                  title: 'Sessiz Saatler (Gece Modu)',
                  subtitle: '23:00 - 08:00 saatleri arasında bildirim seslerini kapat',
                  value: _quietHours,
                  onChanged: (v) => setState(() => _quietHours = v),
                ),
                const Divider(height: 1, indent: 60),
                _buildSwitchTile(
                  icon: Icons.vibration_rounded,
                  iconColor: const Color(0xFFEC4899),
                  title: 'Titreşimli Uyarı',
                  subtitle: 'Bildirimlerde hafif dokunsal geri bildirim ver',
                  value: _vibration,
                  onChanged: (v) => setState(() => _vibration = v),
                ),
                const Divider(height: 1, indent: 60),
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.music_note_rounded, color: Theme.of(context).colorScheme.primary, size: 20),
                  ),
                  title: const Text('Bildirim Sesi', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                  subtitle: Text(_soundPreference, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  trailing: DropdownButton<String>(
                    value: _soundPreference,
                    underline: const SizedBox(),
                    items: _soundOptions.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                    onChanged: (val) {
                      if (val != null) setState(() => _soundPreference = val);
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),
            Container(
              width: double.infinity,
              height: 54,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.secondary,
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                onPressed: () {
                  AppSnackBar.showSuccess(context, 'Akıllı bildirim tercihleri başarıyla kaydedildi!');
                  Navigator.pop(context);
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.save_rounded, color: Colors.white),
                    SizedBox(width: 10),
                    Text(
                      'Ayarları Kaydet',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ).animate().fadeIn(delay: 200.ms, duration: 400.ms).slideY(begin: 0.1),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title.toUpperCase(),
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.2,
        color: Colors.grey,
      ),
    );
  }

  Widget _buildCardWrapper(bool isDark, {required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? Colors.white10 : Colors.black.withOpacity(0.05),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      secondary: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: iconColor.withOpacity(0.15),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: iconColor, size: 20),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      value: value,
      onChanged: onChanged,
      activeColor: Theme.of(context).colorScheme.primary,
    );
  }
}

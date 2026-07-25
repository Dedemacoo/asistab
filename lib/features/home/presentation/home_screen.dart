import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import '../../obligations/presentation/providers/obligation_provider.dart';
import '../../obligations/presentation/widgets/add_obligation_bottom_sheet.dart';
import '../../profile/presentation/providers/user_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final obligationState = ref.watch(obligationProvider);
    final obligations = obligationState.obligations;
    final riskScore = obligationState.overallRiskScore;
    final uncompletedCount = obligations.where((o) => !o.isPaid).length;

    final String firstName = (user?.name != null && user!.name!.trim().isNotEmpty)
        ? user.name!.trim().split(' ').first
        : 'Kullanıcı';

    String riskText = 'Harika Gidiyorsun';
    String riskSubtext = 'Şu anlık acil bir işlemin yok.';
    Color riskColor = Theme.of(context).colorScheme.primary;

    if (riskScore >= 40) {
      riskText = 'Risk Puanı Kritik';
      riskSubtext = 'Gecikmiş veya çok yakında süresi dolacak işlemlerin var!';
      riskColor = Theme.of(context).colorScheme.error;
    } else if (riskScore >= 15) {
      riskText = 'Risk Puanı Yüksek';
      riskSubtext = 'Yaklaşan bazı ödeme veya işlemlerin var.';
      riskColor = Colors.orange;
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Merhaba, $firstName 👋',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Bugün yapılması gereken $uncompletedCount işlemin var.',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                            ),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                    backgroundImage: (user?.profilePicturePath != null && user!.profilePicturePath!.isNotEmpty)
                        ? NetworkImage(user.profilePicturePath!)
                        : null,
                    child: (user?.profilePicturePath == null || user!.profilePicturePath!.isEmpty)
                        ? Text(
                            firstName.isNotEmpty ? firstName[0].toUpperCase() : 'K',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          )
                        : null,
                  ),
                ],
              ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.1),
              const SizedBox(height: 32),
              
              // Risk Puanı Widget (Glassmorphism)
              GlassContainer(
                height: 120,
                width: double.infinity,
                blur: 15,
                color: riskColor.withOpacity(0.1),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    riskColor.withOpacity(0.2),
                    riskColor.withOpacity(0.05),
                  ],
                ),
                border: Border.fromBorderSide(BorderSide(
                  color: riskColor.withOpacity(0.2),
                  width: 1,
                )),
                shadowStrength: 8,
                borderRadius: BorderRadius.circular(24),
                shadowColor: riskColor.withOpacity(0.3),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: riskColor.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '$riskScore',
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                  color: riskColor,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              riskText,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              riskSubtext,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ).animate().scale(delay: 150.ms, duration: 400.ms, curve: Curves.easeOutBack).fadeIn(delay: 150.ms),
              
              const SizedBox(height: 32),
              
              // Yaklaşan İşlemler
              Text(
                'Yaklaşan İşlemler',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ).animate().fadeIn(delay: 300.ms).slideX(begin: -0.05),
              const SizedBox(height: 16),
              
              Expanded(
                child: obligationState.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : obligations.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.check_circle_outline, size: 64, color: Theme.of(context).colorScheme.primary.withOpacity(0.5)),
                                const SizedBox(height: 16),
                                const Text('Henüz eklenmiş bir işleminiz yok.'),
                              ],
                            ),
                          )
                        : ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: obligations.length,
                            itemBuilder: (context, index) {
                              final obs = obligations[index];
                              
                              final daysLeft = obs.deadline.difference(DateTime.now()).inDays;
                              final isUrgent = !obs.isPaid && daysLeft <= 3;
                              
                              IconData icon = Icons.receipt;
                              if (obs.category == 'Garanti') icon = Icons.security;
                              if (obs.category == 'Taşıt') icon = Icons.directions_car;
                              if (obs.category == 'Sağlık') icon = Icons.local_hospital;
                              if (obs.category == 'Abonelik') icon = Icons.subscriptions;
                              if (obs.category == 'Fatura') icon = Icons.electrical_services;

                              String subtitle = 'Son gün: ${obs.deadline.day}/${obs.deadline.month}/${obs.deadline.year}';
                              if (daysLeft < 0) {
                                subtitle = '${-daysLeft} gün gecikti!';
                              } else if (daysLeft == 0) {
                                subtitle = 'Son gün: Bugün';
                              } else if (daysLeft <= 15) {
                                subtitle = 'Son gün: $daysLeft gün sonra';
                              }

                              return Padding(
                                padding: const EdgeInsets.only(bottom: 12.0),
                                child: _buildObligationCard(
                                  context, 
                                  obs.title, 
                                  subtitle, 
                                  '${obs.amount > 0 ? obs.amount : '-'} ₺', 
                                  icon, 
                                  isUrgent,
                                ),
                              )
                              .animate()
                              .fadeIn(delay: (100 * index).ms, duration: 400.ms, curve: Curves.easeOutCubic)
                              .slideY(begin: 0.15, delay: (100 * index).ms, duration: 400.ms, curve: Curves.easeOutCubic);
                            },
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildObligationCard(BuildContext context, String title, String subtitle, String amount, IconData icon, bool isUrgent) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          // Darker drop shadow for depth
          BoxShadow(
            color: isDark ? Colors.black.withOpacity(0.7) : Colors.black.withOpacity(0.1),
            offset: const Offset(4, 6),
            blurRadius: 16,
            spreadRadius: 0,
          ),
          // Inner light highlight for 3D bevel edge
          BoxShadow(
            color: isDark ? Colors.white.withOpacity(0.05) : Colors.white,
            offset: const Offset(-2, -2),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).cardTheme.color!.withOpacity(isDark ? 0.9 : 1.0),
            Theme.of(context).cardTheme.color!.withOpacity(isDark ? 0.5 : 0.9),
          ],
        ),
        border: Border.all(
          color: isDark ? Colors.white.withOpacity(0.08) : Colors.white,
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: isUrgent 
                        ? [Theme.of(context).colorScheme.error.withOpacity(0.2), Theme.of(context).colorScheme.error.withOpacity(0.05)]
                        : [Theme.of(context).colorScheme.primary.withOpacity(0.2), Theme.of(context).colorScheme.primary.withOpacity(0.05)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: isUrgent 
                          ? Theme.of(context).colorScheme.error.withOpacity(0.2) 
                          : Theme.of(context).colorScheme.primary.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(2, 4),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isUrgent 
                        ? Theme.of(context).colorScheme.error.withOpacity(0.4) 
                        : Theme.of(context).colorScheme.primary.withOpacity(0.4),
                      width: 1,
                    )
                  ),
                  child: Icon(
                    icon,
                    color: isUrgent ? Theme.of(context).colorScheme.error : Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: isUrgent ? Theme.of(context).colorScheme.error : Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                          fontWeight: isUrgent ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  amount,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

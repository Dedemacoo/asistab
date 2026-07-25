import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';

import '../../../core/theme/app_theme.dart';
import 'home_screen.dart';
import '../../documents/presentation/documents_screen.dart';
import '../../calendar/presentation/calendar_screen.dart';
import '../../profile/presentation/profile_screen.dart';
import '../../ai_scanner/presentation/ai_scanner_screen.dart';
import '../../ai_scanner/presentation/ai_scanner_helper.dart';
import '../../obligations/presentation/widgets/add_obligation_bottom_sheet.dart';

// Current Index Provider
final bottomNavIndexProvider = StateProvider<int>((ref) => 0);

class MainScaffold extends ConsumerWidget {
  const MainScaffold({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(bottomNavIndexProvider);

    final List<Widget> screens = [
      const HomeScreen(),
      const DocumentsScreen(),
      const SizedBox.shrink(), // Ortadaki AI butonu için boşluk
      const CalendarScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        switchInCurve: Curves.easeOutCubic,
        switchOutCurve: Curves.easeInCubic,
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.98, end: 1.0).animate(animation),
              child: child,
            ),
          );
        },
        child: KeyedSubtree(
          key: ValueKey<int>(currentIndex),
          child: screens[currentIndex],
        ),
      ),
      floatingActionButton: currentIndex == 0
          ? GestureDetector(
              onTap: () => AiScannerHelper.showScannerOptions(context, ref),
              child: Container(
                width: 68,
                height: 68,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primaryColor.withOpacity(0.5),
                      blurRadius: 20,
                      spreadRadius: 4,
                    ),
                    BoxShadow(
                      color: AppTheme.primaryColor.withOpacity(0.25),
                      blurRadius: 40,
                      spreadRadius: 8,
                    ),
                  ],
                  image: const DecorationImage(
                    image: AssetImage('assets/images/app_icon.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: GlassContainer(
        height: 80,
        blur: 20,
        color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.7),
        border: Border.fromBorderSide(BorderSide.none),
        shadowStrength: 0,
        child: BottomNavigationBar(
          currentIndex: currentIndex == 2 ? 0 : currentIndex, // Ortada FAB var
          onTap: (index) {
            if (index != 2) {
              ref.read(bottomNavIndexProvider.notifier).state = index;
            }
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppTheme.primaryColor,
          unselectedItemColor: AppTheme.textSecondaryColor,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: 'Ana Sayfa',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.folder_copy_rounded),
              label: 'Belgeler',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.abc, color: Colors.transparent), // Gizli icon FAB için
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month_rounded),
              label: 'Takvim',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }
}

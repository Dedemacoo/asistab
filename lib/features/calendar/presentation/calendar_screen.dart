import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../obligations/presentation/providers/obligation_provider.dart';

class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({super.key});

  @override
  ConsumerState<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final obligationState = ref.watch(obligationProvider);
    final obligations = obligationState.obligations;

    // Seçili güne ait işlemleri bul (Sadece yıl, ay, gün eşleşmesi)
    final selectedDayObligations = obligations.where((obs) {
      final selected = _selectedDay ?? _focusedDay;
      return obs.deadline.year == selected.year &&
             obs.deadline.month == selected.month &&
             obs.deadline.day == selected.day;
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Takvim')),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Card(
                child: TableCalendar(
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  },
                  eventLoader: (day) {
                    return obligations.where((obs) {
                      return obs.deadline.year == day.year &&
                             obs.deadline.month == day.month &&
                             obs.deadline.day == day.day;
                    }).toList();
                  },
                  calendarStyle: CalendarStyle(
                    todayDecoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                    markerDecoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.error,
                      shape: BoxShape.circle,
                    ),
                  ),
                  headerStyle: const HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                  ),
                ),
              ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.05),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardTheme.color,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    const SizedBox(height: 24),
                    Text(
                      'Seçili Günün İşlemleri',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    if (selectedDayObligations.isEmpty)
                      const Padding(
                        padding: EdgeInsets.only(top: 32.0),
                        child: Center(child: Text('Bu güne ait işlem bulunmuyor.')),
                      ),
                    ...selectedDayObligations.map((obs) => ListTile(
                          leading: Icon(
                            obs.isPaid ? Icons.check_circle : Icons.circle, 
                            color: obs.isPaid ? Colors.green : Theme.of(context).colorScheme.error, 
                            size: 20
                          ),
                          title: Text(obs.title),
                          subtitle: Text(obs.category),
                          trailing: Text('${obs.amount} ₺', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

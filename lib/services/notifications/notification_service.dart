import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_data;
import 'dart:ui';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    tz_data.initializeTimeZones();

    const AndroidInitializationSettings androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notificationsPlugin.initialize(initSettings);
  }

  Future<void> scheduleAdaptiveNotification({
    required int id,
    required String title,
    required String body,
    required DateTime deadline,
    required int daysBefore,
  }) async {
    final notificationTime = deadline.subtract(Duration(days: daysBefore));
    
    // Geçmiş zamana bildirim kurulamaz
    if (notificationTime.isBefore(DateTime.now())) return;

    await _notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(notificationTime, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'asistab_channel',
          'Akıllı Bildirimler',
          channelDescription: 'Yükümlülük ve son tarih bildirimleri.',
          importance: Importance.max,
          priority: Priority.high,
          color: Color(0xFF007AFF), // Apple Blue
        ),
        iOS: DarwinNotificationDetails(
          interruptionLevel: InterruptionLevel.timeSensitive,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  // T-30, T-15, T-7, T-3, T-1 ve T-0 için otomatik çoklu kurgu
  Future<void> scheduleFullChain(int baseId, String title, DateTime deadline) async {
    final Map<int, String> alerts = {
      30: 'Gelecek ay işleminiz var.',
      15: 'İşleminize 15 gün kaldı.',
      7: 'İşleminize 1 hafta kaldı!',
      3: 'Sadece 3 gün kaldı, unutmayın!',
      1: 'Yarın son gün! Acil!',
      0: 'Bugün son gün! Risk almayın, hemen halledin!',
    };

    alerts.forEach((days, message) async {
      await scheduleAdaptiveNotification(
        id: baseId + days, 
        title: title, 
        body: message, 
        deadline: deadline, 
        daysBefore: days,
      );
    });
  }
}

final notificationServiceProvider = Provider<NotificationService>((ref) {
  return NotificationService();
});

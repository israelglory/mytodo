import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mytodo/data/model/params/tasks/tasks_param.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    as fln;

class LocalNotificationService {
  static final LocalNotificationService _instance =
      LocalNotificationService._internal();
  factory LocalNotificationService() => _instance;
  LocalNotificationService._internal();

  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();
  bool _isInitialized = false;

  Future<void> initialize() async {
    if (_isInitialized) return;

    // Initialize timezone
    tz.initializeTimeZones();

    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      requestProvisionalPermission: false,
      defaultPresentAlert: true,
      defaultPresentBadge: true,
      defaultPresentSound: true,
    );

    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notifications.initialize(
      settings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    // Create notification channel for Android
    await _createNotificationChannel();

    _isInitialized = true;
  }

  Future<void> _createNotificationChannel() async {
    const androidNotificationChannel = AndroidNotificationChannel(
      'task_reminders',
      'Task Reminders',
      description: 'Reminders for upcoming tasks',
      importance: Importance.high,
      enableVibration: true,
      playSound: true,
    );

    await _notifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(androidNotificationChannel);
  }

  void _onNotificationTapped(NotificationResponse notificationResponse) {
    // Handle notification tap if needed
    log('Notification tapped: ${notificationResponse.payload}');
  }

  /// Schedule reminder 2 minutes before due date
  Future<void> scheduleTaskReminder(Task task) async {
    if (!_isInitialized) await initialize();

    final reminderTime = task.dueDate.subtract(const Duration(minutes: 2));

    // Don't schedule if reminder time is in the past
    if (reminderTime.isBefore(DateTime.now())) {
      log('Reminder time is in the past for task: ${task.title}');
      return;
    }

    try {
      final scheduledDate = tz.TZDateTime.from(reminderTime, tz.local);

      await _notifications.zonedSchedule(
        task.id.hashCode, // Unique ID based on task ID
        'Task Reminder',
        '${task.title} is due in 2 minutes',
        scheduledDate,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'task_reminders',
            'Task Reminders',
            channelDescription: 'Reminders for upcoming tasks',
            importance: Importance.high,
            priority: fln.Priority.high,
            icon: '@mipmap/ic_launcher',
            enableVibration: true,
            playSound: true,
          ),
          iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
            interruptionLevel: InterruptionLevel.active,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        payload: task.id,
      );

      log('Scheduled reminder for task: ${task.title} at $reminderTime');
    } catch (e) {
      log('Error scheduling notification for task ${task.title}: $e');
    }
  }

  /// Cancel task reminder
  Future<void> cancelTaskReminder(String taskId) async {
    if (!_isInitialized) return;

    try {
      await _notifications.cancel(taskId.hashCode);
      log('Cancelled reminder for task: $taskId');
    } catch (e) {
      log('Error cancelling notification for task $taskId: $e');
    }
  }

  /// Cancel all notifications (useful when switching users)
  Future<void> cancelAllNotifications() async {
    if (!_isInitialized) return;

    try {
      await _notifications.cancelAll();
      log('Cancelled all notifications');
    } catch (e) {
      log('Error cancelling all notifications: $e');
    }
  }

  /// Get pending notifications (for debugging)
  Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    if (!_isInitialized) return [];

    try {
      return await _notifications.pendingNotificationRequests();
    } catch (e) {
      log('Error getting pending notifications: $e');
      return [];
    }
  }

  /// Request permissions (especially for iOS)
  Future<bool> requestPermissions() async {
    if (!_isInitialized) await initialize();

    try {
      final androidImplementation = _notifications
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >();
      final iosImplementation = _notifications
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >();

      if (androidImplementation != null) {
        final granted = await androidImplementation
            .requestNotificationsPermission();
        return granted ?? false;
      }

      if (iosImplementation != null) {
        final granted = await iosImplementation.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
        return granted ?? false;
      }

      return true; // Default to true for other platforms
    } catch (e) {
      log('Error requesting permissions: $e');
      return false;
    }
  }

  /// Test notification (for development/testing)
  Future<void> showTestNotification() async {
    if (!_isInitialized) await initialize();

    await _notifications.show(
      999,
      'Test Notification',
      'Local notifications are working!',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'task_reminders',
          'Task Reminders',
          channelDescription: 'Reminders for upcoming tasks',
          importance: Importance.high,
          priority: fln.Priority.high,
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
    );

    log('Test notification triggered');
  }

  /// Test immediate notification (for iOS simulator testing)
  Future<void> showImmediateTestNotification() async {
    if (!_isInitialized) await initialize();

    await _notifications.show(
      998,
      '🔔 iOS Test',
      'Testing iOS notifications - this should appear immediately!',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'task_reminders',
          'Task Reminders',
          channelDescription: 'Reminders for upcoming tasks',
          importance: Importance.high,
          priority: fln.Priority.high,
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
          interruptionLevel: InterruptionLevel.active,
        ),
      ),
    );

    log('iOS test notification sent immediately');
  }
}

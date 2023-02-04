import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

const FCM_SERVER_KEY =
    'AAAAJcvZctE:APA91bGJr3H46xECW4suT0iI3biHkvFrPwzViiZNdgmGgutuPL0FinCqhsfNt19qE2HQoNqnZ4vvDTeaxSP5ReIT-0Zuzg0AReBzS-Y2wtHXAxyMbEU23gxyQRnO8wA5oBDMJ-GzuUBE';

FirebaseMessaging messaging = FirebaseMessaging.instance;

class Notifications {
  /// Handles sending FCM notifications
  /// using Google's FCM api.
  static Notifications get instance => Notifications();
  static const Map<String, dynamic> DEFAULT_NOTIFICATION_DATA = {
    'click_action': 'FLUTTER_NOTIFICATION_CLICK',
    'type': 'default',
  };
  Future<String> send(
    String fcmToken, {
    String? title,
    String? body,
    Map<String, dynamic> data = DEFAULT_NOTIFICATION_DATA,
  }) async {
    /// Sends a notification with the
    /// given title and body to the given
    /// FCM token.
    try {
      http.Response r = await http.post(
        Uri.parse("https://fcm.googleapis.com/fcm/send"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=${FCM_SERVER_KEY}',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'title': title,
              'body': body,
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            },
            'priority': 'high',
            'data': data,
            'to': await messaging.getToken(),
          },
        ),
      );

      return r.body;
    } catch (e) {
      return e.toString();
    }
  }
}

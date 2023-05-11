import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
class Fcm {
 static  Future<void> backgroundHandler(RemoteMessage message) async {
    print(message.data.toString());
    print(message.notification!.title);
  }
}
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:push_notification/push_notification.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ldp_gateway/utils/share_preferences/Preferences.dart';

late int count = 0;
late Notificator notification;
String notificationKey = 'key';
late String token = '';

Future<void> initializeService() async {
  WidgetsFlutterBinding.ensureInitialized();
  final service = FlutterBackgroundService();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  token = prefs.getString(Preferences.token)!;

  print('test1');
  print(token);

  notification = Notificator(
    onPermissionDecline: () {
      // ignore: avoid_print
      print('permission decline');
    },
    onNotificationTapCallback: (notificationData) {},
  )..requestPermissions(
    requestSoundPermission: true,
    requestAlertPermission: true,
  );

  Timer.periodic(const Duration(seconds: 20), (timer) async {
    String contentNotification = "";

    //contentNotification = await GetApiForNotification().getForDepartment(token);

    notification.show(
      count++,
      'Admin',
      'Thông báo ' + count.toString(),
      imageUrl: "https://vtcc.vn/wp-content/themes/vtcc/images/logo.png",
      notificationSpecifics: NotificationSpecifics(
        AndroidNotificationSpecifics(
          autoCancelable: true,
        ),
      ),
    );
    // notification.show(
    //   count++,
    //   'Đồng chí ' + Personal.user.displayName,
    //   contentNotification,
    //   imageUrl: 'assets/images/app_icon_1.png',
    //   data: {notificationKey: '[notification data]'},
    //   notificationSpecifics: NotificationSpecifics(
    //     AndroidNotificationSpecifics(
    //       autoCancelable: true,
    //     ),
    //   ),
    // );
    //}
  });

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      isForegroundMode: true,
      // auto start service
      autoStart: true,
      // this will executed when app is in foreground or background in separated isolate
      onStart: onStart,
    ),
    iosConfiguration: IosConfiguration(
      // auto start service
      autoStart: true,
      // this will executed when app is in foreground in separated isolate
      onForeground: onStart,
      // you have to enable background fetch capability on xcode project
      onBackground: onIosBackground,
    ),
  );
  service.startService();
}

// to ensure this executed
// run app from xcode, then from xcode menu, select Simulate Background Fetch
bool onIosBackground() {
  WidgetsFlutterBinding.ensureInitialized();
  print('FLUTTER BACKGROUND FETCH');
  return true;
}

void onStart() async {
  WidgetsFlutterBinding.ensureInitialized();
  // // SharedPreferences.setMockInitialValues({});
  // // SharedPreferences prefs = await SharedPreferences.getInstance();
  // // token = prefs.getString(Preferences.token)!;
  // //
  // // print('test2');
  // // print(token);
  //
  // if (service is AndroidServiceInstance) {
  //   service.on('setAsForeground').listen((event) {
  //     service.setAsForegroundService();
  //   });
  //
  //   service.on('setAsBackground').listen((event) {
  //     service.setAsBackgroundService();
  //   });
  // }
  //
  // service.on('stopService').listen((event) {
  //   service.stopSelf();
  // });
  //
  // if (service is AndroidServiceInstance) {
  //   service.setAsBackgroundService();
  // }
  //
  // Timer.periodic(const Duration(seconds: 1), (timer) async {
  //   /// you can see this log in logcat
  //   print('FLUTTER BACKGROUND SERVICE: ${DateTime.now()}');
  //
  //   // test using external plugin
  //   final deviceInfo = DeviceInfoPlugin();
  //   String? device;
  //   if (Platform.isAndroid) {
  //     final androidInfo = await deviceInfo.androidInfo;
  //     device = androidInfo.model;
  //   }
  //
  //   if (Platform.isIOS) {
  //     final iosInfo = await deviceInfo.iosInfo;
  //     device = iosInfo.model;
  //   }
  //
  //   service.invoke('update',
  //     {
  //       "current_date": DateTime.now().toIso8601String(),
  //       "device": device,
  //     },
  //   );
  // });

  // Timer.periodic(Duration(seconds: 10), (timer) async {
  //   if(DateTime.now().second > 0 && DateTime.now().second < 10) {
  //     notification.show(
  //       count++,
  //       'Admin',
  //       'Thông báo ' + count.toString(),
  //       imageUrl: File("assets/images/app_icon_1.png").path,
  //       notificationSpecifics: NotificationSpecifics(
  //         AndroidNotificationSpecifics(
  //           autoCancelable: true,
  //         ),
  //       ),
  //     );
  //   }
  // });

  // Timer.periodic(const Duration(seconds: 20), (timer) async {
  //   String contentNotification = "";
  //
  //   contentNotification = await GetApiForNotification().getForDepartment(token);
  //
  //   notification.show(
  //     count++,
  //     'Admin',
  //     'Thông báo ' + count.toString(),
  //     //imageUrl: File("assets/images/app_icon_1.png").path,
  //     notificationSpecifics: NotificationSpecifics(
  //       AndroidNotificationSpecifics(
  //         autoCancelable: true,
  //       ),
  //     ),
  //   );
  //     // notification.show(
  //     //   count++,
  //     //   'Đồng chí ' + Personal.user.displayName,
  //     //   contentNotification,
  //     //   imageUrl: 'assets/images/app_icon_1.png',
  //     //   data: {notificationKey: '[notification data]'},
  //     //   notificationSpecifics: NotificationSpecifics(
  //     //     AndroidNotificationSpecifics(
  //     //       autoCancelable: true,
  //     //     ),
  //     //   ),
  //     // );
  //     //}
  // });
}

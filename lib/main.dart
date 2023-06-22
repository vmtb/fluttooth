import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trivo/utils/app_styles.dart';
import 'package:trivo/utils/config.dart';

import 'controllers/settings_controller.dart';
import 'screens/splash_page.dart';
import 'utils/app_func.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /*Firebase initialization*/
  await Firebase.initializeApp();

  /*FCM Notifications*/
  await setupFlutterNotificationsCreateChannel();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessage.listen((RemoteMessage event) {
    log("message recieved");
    log(event.notification!.body);
    showFlutterNotification(event);
  });

  /*Run app*/
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Trivo',
      debugShowCheckedModeBanner: false,
      theme: AppStyles.themeData(ref.watch(darkProvider), context),
      darkTheme: AppStyles.themeData(true, context),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('fr')
      ],
      home: const SplashPage(),
    );
  }
}



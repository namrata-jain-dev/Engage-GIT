
import 'package:engage/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'login/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      name:"EngageGIT",
        options: const FirebaseOptions(
          apiKey: 'AIzaSyA6EYfXVcqdIDzvWSPoZtInXKKI671CHqI',
          appId: '1:339195447974:android:8575f2aa296050bbd80267',
          messagingSenderId: '339195447974',
          projectId: 'engage-git',
          storageBucket: 'sengage-git.firebasestorage.app',
        ));
  }
  // await FlutterLocalization.instance.ensureInitialized();
  runApp( MyApp());
}

class MyApp extends StatefulWidget {
   MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // final FlutterLocalization _localization = FlutterLocalization.instance;
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690), // Set your design mockup's size here
      minTextAdapt: true, // Ensures text scaling
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          // locale: Locale('en'),
          // supportedLocales: _localization.supportedLocales,
          // localizationsDelegates: _localization.localizationsDelegates,
          // theme: ThemeData(fontFamily: _localization.fontFamily),
          home: SplashScreen(),
        );
      },
    );
  }
}


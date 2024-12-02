
import 'package:engage/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: 'AIzaSyA6EYfXVcqdIDzvWSPoZtInXKKI671CHqI',
        appId: '1:339195447974:android:8575f2aa296050bbd80267',
        messagingSenderId: '339195447974',
        projectId: 'engage-git',
        storageBucket: 'sengage-git.firebasestorage.app',
      ));
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690), // Set your design mockup's size here
      minTextAdapt: true, // Ensures text scaling
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        );
      },
    );
  }
}


import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagramclone/responsive/mobile_screen_layout.dart';
import 'package:instagramclone/responsive/responsive_screen_layout.dart';
import 'package:instagramclone/responsive/web_screen_layout.dart';
import 'package:instagramclone/screens/login_screen.dart';
import 'package:instagramclone/screens/signup_screen.dart';
import 'package:instagramclone/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: 'AIzaSyC5pc2VSxYGNgjpsyJ5aK_gTD2eNUeXnsA',
            appId: '1:365450648401:web:9813a827f8844aa8d4d170',
            messagingSenderId: '365450648401',
            projectId: 'instagramclone-41869',
            storageBucket: 'instagramclone-41869.appspot.com'));
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instagram Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark()
          .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
      // home: const ResponsiveLayout(
      //   mobileScreenLayout: MobileScreenLayout(),
      //   webScreenLayout: WebScreenLayout(),
      // )
      home: const SignupScreen(),
    );
  }
}

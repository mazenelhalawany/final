import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_9_final_project/firebase_options.dart';
import 'package:flutter_application_9_final_project/features/onbording/onbording.dart';
import 'package:flutter_application_9_final_project/features/auth/login.dart';
import 'package:flutter_application_9_final_project/features/home/mainpage.dart';
import 'package:flutter_application_9_final_project/features/auth/signup.dart';
import 'package:flutter_application_9_final_project/core/widget/snakBar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const MainPage();
            } else {
              return const Onbording();
            }
          },
        ),
        // initialRoute: '/',
        // routes: {
        //   '/login': (context) =>  LoginPage(),
        //   '/signup': (context) =>  SignupPage(),
        // },
      ),
    );
  }
}

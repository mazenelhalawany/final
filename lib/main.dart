import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_9_final_project/firebase_options.dart';
import 'package:flutter_application_9_final_project/pages/home.dart';
import 'package:flutter_application_9_final_project/pages/login.dart';
import 'package:flutter_application_9_final_project/pages/mainpage.dart';
import 'package:flutter_application_9_final_project/pages/signup.dart';
import 'package:flutter_application_9_final_project/shared/snakBar.dart';
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
              return const HomePage();
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

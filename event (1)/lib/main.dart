import 'package:file_templeate/Auth/signin.dart';
import 'package:file_templeate/Auth/signup.dart';
import 'package:file_templeate/screen/chat_screen.dart';

import 'package:file_templeate/screen/homePage/HomePage.dart';
import 'package:file_templeate/screen/vender/service/AddService.dart';
import 'package:file_templeate/screen/vender/service/Editservice.dart';
import 'package:file_templeate/screen/vender/service/showservices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

import 'OnBording/onPording.dart';

late bool islogin;
var user;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  user = FirebaseAuth.instance.currentUser;

  if (user == null) {
    islogin = false;
  } else {
    islogin = true;
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ShowServices(),
    );
  }
}

class splashscreen extends StatelessWidget {
  const splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Lottie.asset('images/1.json'),
      backgroundColor: Color.fromARGB(255, 253, 253, 253),
      splashIconSize: 1000,
      duration: 2000,
      nextScreen: islogin == true ? HomePage() : OnBording(),
      splashTransition: SplashTransition.slideTransition,
      animationDuration: Duration(seconds: 3),
    );
  }
}

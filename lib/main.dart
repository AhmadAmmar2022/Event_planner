import 'package:carousel_slider/carousel_slider.dart';
import 'package:file_templeate/Auth/signin.dart';
import 'package:file_templeate/Auth/signup.dart';
import 'package:file_templeate/screen/chat_screen.dart';
import 'package:file_templeate/screen/homePage/HomePage.dart';
import 'package:file_templeate/screen/homePage/HomePagePlanner.dart';
import 'package:file_templeate/screen/vender/packageservices/AddPackage.dart';
import 'package:file_templeate/screen/vender/packageservices/detailsPackage.dart';
import 'package:file_templeate/screen/vender/packageservices/showPackage.dart';
import 'package:file_templeate/screen/vender/service/AddService.dart';
import 'package:file_templeate/screen/vender/service/Editservice.dart';
import 'package:file_templeate/screen/vender/service/showservices.dart';
import 'package:file_templeate/widget/slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'OnBording/onPording.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:localization/localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

late bool islogin;
var user;
late SharedPreferences sharedpref;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  user = FirebaseAuth.instance.currentUser;
  sharedpref = await SharedPreferences.getInstance();

  if (user == null) {
    islogin = false;
  } else {
    islogin = true;
  }

  runApp(const MyApp());

  var fbm = FirebaseMessaging.instance;
  fbm.getToken().then((token) {
    print("""""" """""" """""" "this is the token" """""" """""" """""");
    print(token);
    print("***********************");
  });
//this is method used when the app id open forecore
  FirebaseMessaging.onMessage.listen((event) {
    print('---------------- data notification ---------------');
// Navigator.pushReplacement(context,
//                 MaterialPageRoute(builder: (context) => const ShowPackage()));

    print("${event.notification!.body}");
    print("--------------------------------------------------");
  });

//this is used when the app in backgroung mode
  Future BackgroundMessage(RemoteMessage message) async {
    print('*****************backgroung message***********');
    print("${message.notification!.body}");
    print('*****************background********************');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // localizationsDelegates: [
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate,
      // ],
      // supportedLocales: [
      //   const Locale('ar', 'AE'), // English, no country code
      // ],
      locale: Get.deviceLocale,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.amber,
        fontFamily: 'ElMessiri',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline5: TextStyle(
                color: Colors.blue,
                fontSize: 24,
                fontFamily: 'ElMessiri',
                fontWeight: FontWeight.bold,
              ),
              headline6: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontFamily: 'ElMessiri',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      home: splashscreen(),
    );
  }
}

class splashscreen extends StatelessWidget {
  const splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Lottie.asset('images/1.json'),
      backgroundColor: Color.fromRGBO(253, 253, 253, 1),
      splashIconSize: 200,
      duration: 200,
      nextScreen: islogin == true ? ShowPackage() : OnBording(),
      splashTransition: SplashTransition.slideTransition,
      animationDuration: Duration(seconds: 3),
    );
  }
}

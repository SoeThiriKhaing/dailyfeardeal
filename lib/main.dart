import 'package:dailyfeardeal/screens/auth/registerscreen.dart';
import 'package:dailyfeardeal/screens/auth/splashscreen.dart';
import 'package:dailyfeardeal/screens/auth/to_register.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "DailyFairDeal",
      home:const SplashScreen(),
      getPages:[
        GetPage(name: '/', page: ()=>const SplashScreen()),
        GetPage(name: '/toregister', page: ()=>const ToRegister()),
        GetPage(name: '/register', page: ()=>const RegisterScreen())
      ]
    );
  }
}

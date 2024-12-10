import 'package:dailyfairdeal/screens/auth/login/login_screen.dart';
import 'package:dailyfairdeal/screens/auth/signup/merchant_sign_up.dart';
import 'package:dailyfairdeal/screens/auth/signup/registerscreen.dart';
import 'package:dailyfairdeal/screens/auth/signup/rider_sign_up.dart';
import 'package:dailyfairdeal/screens/auth/signup/taxi_driver_sign_up.dart';
import 'package:dailyfairdeal/screens/auth/splashscreen.dart';
import 'package:dailyfairdeal/screens/auth/to_register.dart';
import 'package:dailyfairdeal/screens/food/food_category.dart';
import 'package:dailyfairdeal/screens/food/popularitem.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "DailyFairDeal",
        home: const SplashScreen(),
        getPages: [
          GetPage(name: '/', page: () => const SplashScreen()),
          GetPage(name: '/toregister', page: () => const ToRegister()),
          GetPage(name: '/register', page: () => const RegisterScreen()),
          GetPage(name: '/login', page: () => const LoginScreen()),
          GetPage(name: '/merchantsignup', page: () => const MerchantSignUp()),
          GetPage(name: '/driversignup', page: () => const TaxiDriverSignUp()),
          GetPage(name: '/dfdridersignup', page: () => const RiderSignUp()),
          GetPage(name: '/foodcategory', page: () => FoodPage()),
          GetPage(name: '/merchantsignup', page: () => const MerchantSignUp()),
          GetPage(name: '/popularrestaurant', page:()=>const PopularRestaurantsPage()),
        ]);
  }
}

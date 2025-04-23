import 'package:get/get.dart';
import 'package:dailyfairdeal/screens/auth/login/login_screen.dart';
import 'package:dailyfairdeal/screens/auth/signup/merchant/merchant_sign_up.dart';
import 'package:dailyfairdeal/screens/auth/signup/registerscreen.dart';
import 'package:dailyfairdeal/screens/auth/signup/rider_sign_up.dart';
import 'package:dailyfairdeal/screens/auth/signup/taxi_driver_sign_up.dart';
import 'package:dailyfairdeal/screens/auth/splashscreen.dart';
import 'package:dailyfairdeal/screens/auth/to_register.dart';
import 'package:dailyfairdeal/screens/dashboard/restaurant/restaurant_owner_dashboard.dart';
import 'package:dailyfairdeal/screens/dashboard/restaurant/restaurant_setting/change_restaurant_image.dart';
import 'package:dailyfairdeal/screens/dashboard/restaurant/restaurant_setting/profile_setting.dart';
import 'package:dailyfairdeal/screens/dashboard/taxi_driver/driver_profile.dart';
import 'package:dailyfairdeal/screens/dashboard/taxi_driver/earnings.dart';
import 'package:dailyfairdeal/screens/dashboard/taxi_driver/ride_history.dart';
import 'package:dailyfairdeal/screens/dashboard/taxi_driver/rider_request/ride_request.dart';
import 'package:dailyfairdeal/screens/dashboard/taxi_driver/driver_home.dart';
import 'package:dailyfairdeal/screens/food/foodpage/food_page.dart';
import 'package:dailyfairdeal/screens/home/main_screen.dart';
import 'package:dailyfairdeal/screens/payment/add_card_screen.dart';
import 'package:dailyfairdeal/screens/profile/profile.dart';
import 'package:dailyfairdeal/screens/taxi/taxi_home/taxi_home_screen.dart';

final List<GetPage> appRoutes = [
  GetPage(name: '/', page: () => const SplashScreen()),
  GetPage(name: '/toregister', page: () => const ToRegister()),
  GetPage(name: '/register', page: () => const RegisterScreen()),
  GetPage(name: '/login', page: () => const LoginScreen()),
  GetPage(name: '/merchantsignup', page: () => const MerchantSignUp()),
  GetPage(name: '/driversignup', page: () => const TaxiDriverSignUp()),
  GetPage(name: '/dfdridersignup', page: () => const RiderSignUp()),
  GetPage(name: '/foodcategory', page: () => const FoodPage()),
  GetPage(name: '/profile', page: () => const Profile()),
  GetPage(name: '/main', page: () => MainScreen(email: '',)),
  GetPage(name: '/restaurantownerdashboard', page: () => const RestaurantOwnerDashboard()),
  GetPage(name: '/profilesetting', page: () => const ProfileSetting()),
  GetPage(name: '/changerestaurantimage', page: () => const ChangeRestaurantImage()),
  GetPage(name: '/addcardscreen', page: () => const AddCardScreen()),
  GetPage(name: '/taxi_driver_home', page: () => const TaxiHomeScreen()),
  GetPage(name: '/riderequest', page: () => RideRequest()),
  GetPage(name: '/ride_history', page: () => const RideHistory()),
  GetPage(name: '/earnings', page: () => const Earnings()),
  GetPage(name: '/driver_profile', page: () => const DriverProfile()),
  GetPage(name: '/taxi_home_screen', page: () => const TaxiHomeUserScreen()),
];

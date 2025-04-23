// import 'package:dailyfairdeal/screens/home/main_screen.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class CacheService {
//   final _secureStorage = const FlutterSecureStorage();
//   Future<void> login(String email, String password) async {
//     final sharePref = await SharedPreferences.getInstance();
//     // Save login state and username to SharedPreferences
//     await sharePref.setBool('isLoggedIn', true);
//     await sharePref.setString('email', email);

//     // Store token securely using FlutterSecureStorage (for security purposes)
//     // await _secureStorage.write(key: 'auth_token', value: token);
//   }

//   //Check if user logged in

//   Future<bool> isLoggedIn() async {
//     final sharePref = await SharedPreferences.getInstance();
//     return sharePref.getBool('isLoggedIn') ?? false;
//   }

//   //Get the cached user data

//   Future<Map<String, String?>> getUserData() async {
//     final prefs = await SharedPreferences.getInstance();
//     String? email = prefs.getString('email');

//     // Retrieve the token securely from FlutterSecureStorage
//     String? token = await _secureStorage.read(key: 'auth_token');

//     return {
//       'email': email,
//       'auth_token': token,
//     };
//   }

//   Future<void> logout() async {
//     final pref = await SharedPreferences.getInstance();
//     await pref.remove('isLoggedIn');
//     await pref.remove('email');
//   }

//   //Check User Loggin status

//   Future<void> navigateIfLoggedIn() async {
//     bool isLogged = await isLoggedIn();
//     if (isLogged) {
//       final userData = await getUserData();
//       Get.offAll(() => MainScreen(
//             email: userData['email'] ?? "Guest",
//           ));
//     } else {
//       Get.offAllNamed('/toregister');
//     }
//   }
// }

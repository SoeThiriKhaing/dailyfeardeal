import 'package:dailyfairdeal/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:dailyfairdeal/screens/taxi/taxi_home/taxi_home_controller.dart';
import 'package:dailyfairdeal/screens/auth/splashscreen.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _initializeNotifications();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TaxiHomeController()),
      ],
      child: const MyApp(),
    ),
  );
}

Future<void> _initializeNotifications() async {
  const AndroidInitializationSettings androidSettings =
      AndroidInitializationSettings('@mipmap/dfd');

  const InitializationSettings initSettings =
      InitializationSettings(android: androidSettings);

  await flutterLocalNotificationsPlugin.initialize(
    initSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) {
      _handleNotificationClick(response.payload);
    },
  );
}

void _handleNotificationClick(String? payload) {
  if (payload == "open_ride_requests") {
    Get.toNamed('/riderequest');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorObservers: [routeObserver],
      debugShowCheckedModeBanner: false,
      title: "DailyFairDeal",
      navigatorKey: navigatorKey,
      home: const SplashScreen(),
      getPages: appRoutes,
    );
  }
}

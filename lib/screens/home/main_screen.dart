import 'package:dailyfeardeal/screens/home/activities.dart';
import 'package:dailyfeardeal/screens/home/home.dart';
import 'package:dailyfeardeal/screens/home/payment.dart';
import 'package:dailyfeardeal/screens/home/profile.dart';
import 'package:dailyfeardeal/widget/app_color.dart';
import 'package:dailyfeardeal/widget/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class MainScreen extends StatelessWidget {
  MainScreen({super.key});
  final BottomNav bottomNav = Get.put(BottomNav());
  final List<Widget> pages = [
    const Home(),
    const Activities(),
    const Payment(),
    const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        body: pages[bottomNav.currentIndex.value],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: bottomNav.currentIndex.value,
          onTap: bottomNav.changePage,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColor.primaryColor,
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.white,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.local_activity), label: "Activities"),
            BottomNavigationBarItem(
                icon: Icon(Icons.payment), label: "Payment"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
        )));
  }
}

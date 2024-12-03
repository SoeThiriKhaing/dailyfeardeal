import 'package:dailyfeardeal/widget/app_color.dart';
import 'package:dailyfeardeal/widget/support_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BusinessPage extends StatelessWidget {
  const BusinessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Set Up Business Account',
          style: AppWidget.appBarTextStyle(),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Image at the top
            Container(
                margin: const EdgeInsets.all(10),
                child: Image.asset("assets/images/dfd.png")),
            // Three card views
            _buildCard('Create Own Merchant Account', Colors.white, Icons.shop,
                '/merchantsignup'),
            _buildCard('Create DFD Driver Account', Colors.white,
                Icons.taxi_alert, '/driversignup'),
            _buildCard('Create DFD Rider Account', Colors.white,
                Icons.car_crash, '/dfdridersignup'),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(String title, Color color, IconData icon, String route) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(route);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        color: Colors.white,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                icon,
                color: AppColor.primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

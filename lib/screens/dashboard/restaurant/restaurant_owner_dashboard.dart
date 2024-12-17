import 'package:dailyfairdeal/widget/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RestaurantOwnerDashboard extends StatelessWidget {

  const RestaurantOwnerDashboard({ super.key });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant Owner Dashboard'),
        backgroundColor: AppColor.primaryColor,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: AppColor.primaryColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/images/dfd.png'), 
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Restaurant Owner',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Text(
                    'owner@restaurant.com',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Dashboard'),
              onTap: () {
                Get.back();
              },
            ),
            ListTile(
              leading: const Icon(Icons.restaurant),
              title: const Text('Profile Settings'),
              onTap: () {
                Get.back();
              },
            ),
            ListTile(
              leading: const Icon(Icons.fastfood),
              title: const Text('Food List'),
              onTap: () {
                Get.back();
              },
            ),
            ExpansionTile(
              leading: const Icon(Icons.fastfood),
              title: const Text('Food Management'),
              children: [
                ListTile(
                  title: const Text('Add Category'),
                  onTap: () {
                    Get.back();
                  },
                ),
                ListTile(
                  title: const Text('Add Food'),
                  onTap: () {
                    Get.back();
                  },
                ),
                ListTile(
                  title: const Text('Food List'),
                  onTap: () {
                    Get.back();
                  },
                ),
              ],
            ),
            ExpansionTile(
              leading: const Icon(Icons.list),
              title: const Text('Order Management'),
              children: [
                ListTile(
                  title: const Text('Order List'),
                  onTap: () {
                    Get.back();
                  },
                ),
                ListTile(
                  title: const Text('Order History'),
                  onTap: () {
                    Get.back();
                  },
                ),
                ListTile(
                  title: const Text('Confirm or Cancel Orders'),
                  onTap: () {
                    Get.back();
                  },
                ),
              ],
            ),
            ExpansionTile(
              leading: const Icon(Icons.report),
              title: const Text('Reports & Analytics'),
              children: [
                ListTile(
                  title: const Text('Sales Reports'),
                  onTap: () {
                    Get.back();
                  },
                ),
                ListTile(
                  title: const Text('Popular Items'),
                  onTap: () {
                    Get.back();
                  },
                ),
                ListTile(
                  title: const Text('Customer Trends'),
                  onTap: () {
                    Get.back();
                  },
                ),
              ],
            ),
            ExpansionTile(
              leading: const Icon(Icons.discount),
              title: const Text('Promotions & Discounts'),
              children: [
                ListTile(
                  title: const Text('Manage Discounts'),
                  onTap: () {
                    Get.back();
                  },
                ),
                ListTile(
                  title: const Text('Special Offers'),
                  onTap: () {
                    Get.back();
                  },
                ),
                ListTile(
                  title: const Text('Promotions'),
                  onTap: () {
                    Get.back();
                  },
                ),
              ],
            ),
             ExpansionTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              children: [
                ListTile(
                  title: const Text('Payment Settings'),
                  onTap: () {
                    Get.back();
                  },
                ),
                ListTile(
                  title: const Text('Security Settings'),
                  onTap: () {
                    Get.back();
                  },
                ),
              ],
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                Get.toNamed("/main");
              },
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text(
          'Welcome to the Restaurant Owner Dashboard!',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

import 'package:dailyfairdeal/screens/home/business.dart';
import 'package:dailyfairdeal/widget/app_color.dart';
import 'package:dailyfairdeal/widget/support_widget.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';

class Profile extends StatelessWidget {
  Profile({super.key});

  final List<Map<String, String>> items = [
    {'title': 'Profile Details'},
    {'title': 'Order & Reordering'},
    {'title': 'Vouchers'},
    {'title': 'Favourites'},
    {'title': 'Setting'},
    {'title': 'Safety Setting'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Profile',
          style: AppWidget.appBarTextStyle(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Carousel Slider
            CarouselSlider(
              items: [
                Image.asset("assets/images/dfd.png"),
                Image.asset("assets/images/food1.jpeg"),
                Image.asset("assets/images/food2.jpeg"),
              ],
              options: CarouselOptions(
                height: 200,
                autoPlay: true,
                enlargeCenterPage: true,
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "List Your Business on DailyFairDeal! Be Our Partner?",
                style: AppWidget.labelTextStyle(),
              ),
            ),
            const SizedBox(height: 20),

            // Card View
            GestureDetector(
              onTap: () {
                Get.to(() => const BusinessPage()); // Navigate to BusinessPage
              },
              child: Card(
                color: Colors.white,
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Business Centre',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        Icons.business_center,
                        size: 40.0,
                        color: AppColor.primaryColor,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // List View
            ListView.builder(
              shrinkWrap: true, // Prevents infinite height error
              physics:
                  const NeverScrollableScrollPhysics(), // Prevents list view from scrolling
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return ListTile(
                  leading: const Icon(Icons.star),
                  title: Text(item['title']!), // Access the predefined title
                  trailing:
                      const Icon(Icons.arrow_forward), // Add a forward arrow
                  onTap: () {
                    // Handle onTap event if needed
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Selected: ${item['title']}')),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

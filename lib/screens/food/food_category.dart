import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dailyfairdeal/widget/app_color.dart';
import 'package:dailyfairdeal/widget/support_widget.dart';
import 'food_controller.dart';

class FoodPage extends StatelessWidget {
  final FoodController controller = Get.put(FoodController());

  FoodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        title: Text(
          'Food Page',
          style: AppWidget.appBarTextStyle(),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Material(
              elevation: 5.0,
              shadowColor: Colors.grey.withOpacity(0.4),
              borderRadius: BorderRadius.circular(25.0),
              child: TextField(
                onChanged: controller.updateSearchQuery,
                decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                  hintText: "Search food or restaurant...",
                  prefixIcon: Icon(Icons.search, color: AppColor.primaryColor),
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
          ),

          // Scrollable Row of Buttons
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildCategoryButton('Featured Restaurants', () {
                    controller.fetchFeaturedRestaurants();
                  }),
                  _buildCategoryButton('Popular Items', () {
                    if (kDebugMode) {
                      print("Popular Items clicked");
                    }
                  }),
                  _buildCategoryButton('Your Favourite Cuisines', () {
                    if (kDebugMode) {
                      print("Your Favourite Cuisines clicked");
                    }
                  }),
                  _buildCategoryButton('Order It Again', () {
                    if (kDebugMode) {
                      print("Order It Again clicked");
                    }
                  }),
                ],
              ),
            ),
          ),

          // Dynamic Content
          Expanded(
            child: Obx(() {
              final restaurants = controller.filteredCategories;
              if (restaurants.isEmpty) {
                return const Center(
                  child: Text(
                    'No restaurants found.',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                );
              }
              return ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 30),
                itemCount: restaurants.length,
                itemBuilder: (context, index) {
                  final restaurant = restaurants[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 3.0,
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ListTile(
                        title: Text(
                          restaurant['name'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          "${restaurant['restaurant_type']} - ${restaurant['City_Name']}, ${restaurant['Country_Name']}",
                          style: const TextStyle(fontSize: 14),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios,
                            color: Colors.grey),
                        onTap: () {
                          // Define behavior for tapping a restaurant
                        },
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  // Helper Method to Build Category Buttons
  Widget _buildCategoryButton(String title, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

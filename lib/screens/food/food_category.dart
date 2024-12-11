import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dailyfairdeal/service/api_method.dart';
import 'package:dailyfairdeal/widget/app_color.dart';
import 'package:dailyfairdeal/widget/support_widget.dart';

class FoodPage extends StatelessWidget {
  final APIMethods apiController = Get.put(APIMethods());

  @override
  Widget build(BuildContext context) {
    // Fetch data when the page loads
    apiController.fetchFeaturedRestaurants();

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
            padding: const EdgeInsets.only(
                top: 20.0, left: 10.0, right: 10.0, bottom: 10.0),
            child: Material(
              elevation: 5.0,
              shadowColor: Colors.grey.withOpacity(0.4),
              borderRadius: BorderRadius.circular(25.0),
              child: TextField(
                onChanged: apiController.updateSearchQuery,
                decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                  hintText: "Search your favorite restaurant...",
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
                    apiController.fetchFeaturedRestaurants();
                  }),
                  _buildCategoryButton('Popular Restaurants', () {
                    print("Popular Items clicked");
                  }),
                  _buildCategoryButton('Popular Foods', () {
                    apiController.fetchPopularFoods();
                  }),
                  _buildCategoryButton('Order It Again', () {
                    apiController.fetchOrderAgain();
                  }),
                ],
              ),
            ),
          ),

          // Dynamic Content
          Expanded(
            child: Obx(() {
              final popularFood = apiController.filteredFoods;
              if (popularFood.isEmpty) {
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
                itemCount: popularFood.length,
                itemBuilder: (context, index) {
                  final popularFoods = popularFood[index];
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
                          popularFoods['name'] ?? 'Unnamed Food',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          "${popularFoods['sub_category_id'] ?? 'No Subcategory'}",
                          style: const TextStyle(fontSize: 14),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios,
                            color: Colors.grey),
                        onTap: () {
                         
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
            borderRadius: BorderRadius.circular(10.0),
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

import 'package:dailyfairdeal/widget/app_color.dart';
import 'package:dailyfairdeal/widget/support_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'food_controller.dart';

class FoodPage extends StatelessWidget {
  final FoodController controller = Get.put(FoodController());

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
                  hintText: "Search your favorite food...",
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
                    print("Featured Restaurants clicked");
                  }),
                  _buildCategoryButton('Popular Items', () {
                    print("Popular Items clicked");
                  }),
                  _buildCategoryButton('Your Favourite Cuisines', () {
                    print("Your Favourite Cuisines clicked");
                  }),
                  _buildCategoryButton('Order It Again', () {
                    print("Order It Again clicked");
                  }),
                ],
              ),
            ),
          ),

          // Dynamic Content
          Expanded(
            child: Obx(() {
              final categories = controller.filteredCategories;
              if (categories.isEmpty) {
                return const Center(
                  child: Text(
                    'No categories found.',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                );
              }
              return ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 30),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 3.0,
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              category['image'],
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            category['name'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios,
                              color: Colors.grey),
                          onTap: () {
                            // Define the behavior on category tap.
                          },
                        ),
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

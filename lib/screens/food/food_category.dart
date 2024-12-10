import 'package:dailyfairdeal/service/featureres_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dailyfairdeal/service/api_method.dart';
import 'package:dailyfairdeal/widget/app_color.dart';
import 'package:dailyfairdeal/widget/support_widget.dart';

class FoodPage extends StatelessWidget {
  final APIMethods apiController = Get.put(APIMethods());

  @override
  Widget build(BuildContext context) {
    // Fetch initial data when the page loads
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
            padding: const EdgeInsets.all(4.0),
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
                    FeatureresApi().fetchFeaturedRestaurants();
                  }),
                  _buildCategoryButton('Popular Items', () {
                    apiController.updateCategory('popular');
                  }),
                  _buildCategoryButton('Your Favourite Cuisines', () {
                    apiController.updateCategory('favourite');
                  }),
                  _buildCategoryButton('Order It Again', () {
                    apiController.updateCategory('orderAgain');
                  }),
                ],
              ),
            ),
          ),

          // Dynamic Content
          Expanded(
            child: Obx(() {
              final category = apiController.currentCategory.value;
              final items = category == 'popular'
                  ? apiController.popularItems
                  : apiController.filteredCategories;

              if (items.isEmpty) {
                return const Center(
                  child: Text(
                    'No items found.',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                );
              }

              return ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 30),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: item['image'] != null
                          ? Image.asset(
                              item['image']!,
                              width: 100,
                              height: 200,
                              fit: BoxFit.cover,
                            )
                          : const Icon(Icons.image_not_supported),
                      title: Text(
                        item['name']!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        "${item['description']}",
                        style: const TextStyle(fontSize: 14),
                      ),
                      onTap: () {
                        // Define behavior for tapping an item
                      },
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

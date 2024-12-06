import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FoodController extends GetxController {
  var featuredRestaurants = [].obs; // Observable for storing fetched data
  var filteredCategories = [].obs; // Observable for search functionality

  // Fetch restaurants from API
  Future<void> fetchFeaturedRestaurants() async {
    try {
      final response = await http.get(
        Uri.parse("http://api.dailyfairdeal.com/api/feature-restaurants"),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        featuredRestaurants.value = data['data'];
        filteredCategories.value =
            featuredRestaurants; // Initialize with all data
      } else if (response.statusCode == 401) {
        Get.snackbar("Error", "Unauthorized access.");
      } else {
        Get.snackbar("Error", "Failed to load data.");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    }
  }

  // Filter search results
  void updateSearchQuery(String query) {
    filteredCategories.value = featuredRestaurants
        .where((restaurant) =>
            restaurant['name'].toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}

import 'package:get/get.dart';

class FoodController extends GetxController {
  // List of food categories
  final RxList<Map<String, dynamic>> foodCategories = <Map<String, dynamic>>[
    {'name': 'Pizza House', 'image': 'assets/images/res2.png'},
    {'name': 'Burger House', 'image': 'assets/images/res3.png'},
    {'name': 'Pasta House', 'image': 'assets/images/res4.jpg'},
    {'name': 'Salad House', 'image': 'assets/images/res5.png'},
    {'name': 'Pizza House', 'image': 'assets/images/res2.png'},
    {'name': 'Burger House', 'image': 'assets/images/res3.png'},
    {'name': 'Pasta House', 'image': 'assets/images/res4.jpg'},
    {'name': 'Salad House', 'image': 'assets/images/res5.png'},
  ].obs;

  // Search query
  final RxString searchQuery = ''.obs;

  // Filtered categories based on search
  List<Map<String, dynamic>> get filteredCategories {
    if (searchQuery.value.isEmpty) {
      return foodCategories;
    }
    return foodCategories
        .where((category) => category['name']
            .toLowerCase()
            .contains(searchQuery.value.toLowerCase()))
        .toList();
  }

  // Update search query
  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }
}

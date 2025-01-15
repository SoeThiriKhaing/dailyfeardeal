import 'dart:convert';
import 'package:dailyfairdeal/config/handle_error.dart';
import 'package:dailyfairdeal/service/api_service.dart';
import 'package:dailyfairdeal/util/appurl.dart';
import 'package:get/get.dart';

final RxList<Map<String, dynamic>> popularRestaurant = <Map<String, dynamic>>[].obs;
final apiService = ApiService();

Future<void> fetchPopularRestaurants() async {
  try {
    final response = await apiService.request(AppUrl.getPopularFood, method: "GET");

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      // Clear previous data to avoid duplication
      popularRestaurant.clear();

      // Parse and add new data
      for (var popularRes in data) {
        popularRestaurant.add({
          'id': popularRes['id'].toString(),
          'name': popularRes['name'],
        });
      }
    } else {
      // Handle API errors
      ApiErrorHandler.handleError(response.statusCode);
    }
  } catch (e) {
    // Log and rethrow errors
    throw Exception("Error fetching popular restaurants: $e");
  }
}

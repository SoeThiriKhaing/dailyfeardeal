import 'dart:convert';
import 'package:dailyfairdeal/config/handle_error.dart';
import 'package:dailyfairdeal/service/api_service.dart';
import 'package:dailyfairdeal/util/appurl.dart';
import 'package:get/get.dart';

final RxList<Map<String, dynamic>> restaurantTypes =
    <Map<String, dynamic>>[].obs;
final apiService = ApiService(); // Get the singleton instance of ApiService
var selectedCategory = [].obs;
Future<void> getRestaurantTypes() async {
  try {
    // Use the 'request' method of ApiService to make the GET request
    final response = await apiService.request(
      AppUrl.getResTypes, // Endpoint
      method: "GET", // HTTP method
    );

    if (response.statusCode == 200) {
      // Parse the response body into a list of restaurant types
      final data = json.decode(response.body);
      restaurantTypes.clear();
      for (var type in data) {
        restaurantTypes.add({
          'id': type['id'].toString(),
          'name': type['name'],
        });
      }
    } else {
      ApiErrorHandler.handleError(response.statusCode);
    }
  } catch (e) {
    throw Exception("Error: $e");
  }
}

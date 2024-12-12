import 'dart:convert'; // For jsonDecode
import 'dart:io';
import 'package:dailyfairdeal/service/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

class APIMethods extends GetxController {
  var featuredRestaurants = [].obs;
  var popularItems = [].obs;
  var favoriteCuisines = [].obs;
  var orderAgain = [].obs;

  var filteredCategories = [].obs;

  var selectedCategory = ''.obs;

   Future<List<Map<String, String>>> getRestaurantTypes() async {
    try {
      final token = await getToken();
      if (token == null) {
        throw Exception("Unauthorized: Token not found");
      }
      final response = await http.get(
        Uri.parse("http://api.dailyfairdeal.com/api/restaurant_types"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        // Parse the response body into a list of countries
        final data = json.decode(response.body);
        final List<Map<String, String>> restaurantTypes = [];
        for (var type in data) {
          restaurantTypes.add({
            'id': type['id'].toString(),
            'name': type['name'],
          });
        }
        return restaurantTypes;
      } else if (response.statusCode == 401) {
        // Handle unauthorized error
        throw Exception("Unauthorized: Invalid token");
      } else if (response.statusCode == 500) {
        // Handle internal server error
        throw Exception("Server error. Please try again later.");
      } else {
        throw Exception("Failed to load restaurant type");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  Future<List<Map<String, String>>> getCountries() async {
    try {
      final token = await getToken();
      if (token == null) {
        throw Exception("Unauthorized: Token not found");
      }
      final response = await http.get(
        Uri.parse("http://api.dailyfairdeal.com/api/country"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        // Parse the response body into a list of countries
        final data = json.decode(response.body);
        final List<Map<String, String>> countries = [];
        for (var country in data['data']) {
          countries.add({
            'id': country['id'].toString(),
            'name': country['name'],
          });
        }
        return countries;
      } else if (response.statusCode == 401) {
        // Handle unauthorized error
        throw Exception("Unauthorized: Invalid token");
      } else if (response.statusCode == 500) {
        // Handle internal server error
        throw Exception("Server error. Please try again later.");
      } else {
        throw Exception("Failed to load countries");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  Future<List<Map<String, String>>> getDivisions(int countryId) async {
    try {
      final token = await getToken();
      if (token == null) {
        throw Exception("Unauthorized: Token not found");
      }
      final response = await http.get(
        Uri.parse("http://api.dailyfairdeal.com/api/state/$countryId"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        // Parse the response body into a list of countries
        final data = json.decode(response.body);
        final List<Map<String, String>> divisions = [];
          
          for (var division in data) {
            divisions.add({
              'id': division['id'].toString(),
              'countryId': division['country_id'].toString(),
              'name': division['name'],
            });
          }         
          return divisions;
        
      } else if (response.statusCode == 401) {
        // Handle unauthorized error
        throw Exception("Unauthorized: Invalid credentials");
      } else if (response.statusCode == 500) {
        // Handle internal server error
        throw Exception("Server error. Please try again later.");
      } else {  
        throw Exception("Failed to load divisions");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  Future<List<Map<String, String>>> getCities(int divisionId) async {
    try {
      final token = await getToken();
      if (token == null) {
        throw Exception("Unauthorized: Token not found");
      }
      final response = await http.get(
        Uri.parse("http://api.dailyfairdeal.com/api/city/$divisionId"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        // Parse the response body into a list of countries
        final data = json.decode(response.body);
        final List<Map<String, String>> cities = [];
        for (var city in data) {
          cities.add({
            'id': city['id'].toString(),
            'divisionId': city['state_id'].toString(),
            'name': city['name'],
          });
        }
        return cities;
      } else if (response.statusCode == 401) {
        // Handle unauthorized error
        throw Exception("Unauthorized: Invalid credentials");
      } else if (response.statusCode == 500) {
        // Handle internal server error
        throw Exception("Server error. Please try again later.");
      } else {
        throw Exception("Failed to load cities");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  Future<List<Map<String, String>>> getTownships(int cityId) async {
    try {
      final token = await getToken();
      if (token == null) {
        throw Exception("Unauthorized: Token not found");
      }
      final response = await http.get(
        Uri.parse("http://api.dailyfairdeal.com/api/township/$cityId"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        // Parse the response body into a list of countries
        final data = json.decode(response.body);
        final List<Map<String, String>> townships = [];
        for (var township in data) {
          townships.add({
            'id': township['id'].toString(),
            'cityId': township['city_id'].toString(),
            'name': township['name'],
          });
        }
        return townships;
      } else if (response.statusCode == 401) {
        // Handle unauthorized error
        throw Exception("Unauthorized: Invalid credentials");
      } else if (response.statusCode == 500) {
        // Handle internal server error
        throw Exception("Server error. Please try again later.");
      } else {
        throw Exception("Failed to load townships");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  Future<List<Map<String, String>>> getWards(int townshipId) async {
    try {
      final token = await getToken();
      if (token == null) {
        throw Exception("Unauthorized: Token not found");
      }
      final response = await http.get(
        Uri.parse("http://api.dailyfairdeal.com/api/ward/$townshipId"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        // Parse the response body into a list of countries
        final data = json.decode(response.body);
        final List<Map<String, String>> wards = [];
        for (var ward in data) {
          wards.add({
            'id': ward['id'].toString(),
            'townshipId': ward['township_id'].toString(),
            'name': ward['name'],
          });
        }
        return wards;
      } else if (response.statusCode == 401) {
        // Handle unauthorized error
        throw Exception("Unauthorized: Invalid credentials");
      } else if (response.statusCode == 500) {
        // Handle internal server error
        throw Exception("Server error. Please try again later.");
      } else {
        throw Exception("Failed to load wards");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  Future<List<Map<String, String>>> getStreets(int wardId) async {
    try {
      final token = await getToken();
      if (token == null) {
        throw Exception("Unauthorized: Token not found");
      }
      final response = await http.get(
        Uri.parse("http://api.dailyfairdeal.com/api/street/$wardId"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        // Parse the response body into a list of countries
        final data = json.decode(response.body);
        final List<Map<String, String>> streets = [];
        for (var street in data ) {
          streets.add({
            'id': street['id'].toString(),
            'wardId': street['ward_id'].toString(),
            'name': street['name'],
          });
        }
        return streets;
      } else if (response.statusCode == 401) {
        // Handle unauthorized error
        throw Exception("Unauthorized: Invalid credentials");
      } else if (response.statusCode == 500) {
        // Handle internal server error
        throw Exception("Server error. Please try again later.");
      } else {
        throw Exception("Failed to load streets");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  Future<List<Map<String, dynamic>>> searchItemsByType(String query, String type) async {
    try {
      final token = await getToken();
      if (token == null) {
        throw Exception("Unauthorized: Token not found");
      }
      final uri = Uri.parse("http://api.dailyfairdeal.com/api/search");

      // JSON body
      final body = json.encode({
        'q': query,
        'type': type,
      });

      // Make the POST request
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: body,
      );

      // Handle the response
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return List<Map<String, dynamic>>.from(data['data']);
      } else if (response.statusCode == 401) {
        throw Exception("Unauthorized: Invalid credentials");
      } else if (response.statusCode == 500) {
        throw Exception("Server error. Please try again later.");
      } else {
        throw Exception("Failed to load search results");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  Future<String?> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse("http://api.dailyfairdeal.com/api/login"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // Extract the token from the response
        final token = data['access_token'];
        return token; // Return the token for future use
      } else if (response.statusCode == 401) {
        // Unauthorized error (Invalid credentials)
        Get.snackbar(
          "Error",
          "Invalid Email or Password. Please try again.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
        );
      } else if (response.statusCode == 500) {
        // Server error
        Get.snackbar(
          "Error",
          "Internal server error. Please try again later.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
        );
      } else {
        // Other errors
        Get.snackbar(
          "Error",
          "Something went wrong. Please try again.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
        );
      }
    } on SocketException {
      // Network connection error
      Get.snackbar(
        "Error",
        "Unable to connect. Please check your internet connection.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
      );
    } catch (e) {
      // Handle any other exceptions
      Get.snackbar(
        "Error",
        "An unexpected error occurred. Please try again.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
      );
    }
    return null;
  }

  Future<String?> register(String name, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse("http://api.dailyfairdeal.com/api/signup"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'name': name,
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // Extract the token from the response
        final token = data['access_token'];
        return token; // Return the token for future use
      }else if (response.statusCode == 302) {
        // Unauthorized error (Invalid credentials)
        Get.snackbar(
          "Error",
          "The email is already used. Please try again.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red
        );
      } else if (response.statusCode == 401) {
        // Unauthorized error (Invalid credentials)
        Get.snackbar(
          "Error",
          "Invalid Email or Password. Please try again.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red
        );
      } else if (response.statusCode == 500) {
        // Server error
        Get.snackbar(
          "Error",
          "Internal server error. Please try again later.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red
        );
      }else {
        // Other errors
         Get.snackbar(
          "Error",
          "Something went wrong. Please try again.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red
        );
      } 
    }on SocketException {
      // Network connection error
      Get.snackbar(
        "Error",
        "Unable to connect. Please check your internet connection.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
      );
    } catch (e) {
      // Handle any exceptions
      Get.snackbar("Error", "An unexpected error occurred. Please try again.", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
    }
    return null;
  }

  //To show in Home Page
  Future<List<Map<String, String>>?> getFeaturedRestaurants() async {
    try {
      final token = await getToken();
      if (token == null) {
        throw Exception("Unauthorized: Token not found");
      }
      final response = await http.get(
        Uri.parse("http://api.dailyfairdeal.com/api/feature-restaurants"),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
          },
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<Map<String, String>> featureRestaurants = data;
        return featureRestaurants;
        
      } else if (response.statusCode == 401) {
        Get.snackbar("Error", "Unauthorized access.", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
      }else if (response.statusCode == 500) {
        // Server error
        Get.snackbar(
          "Error",
          "Internal server error. Please try again later.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red
        );
      } else {
        Get.snackbar("Error", "Failed to load data.", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
    }
    return null;
  }

  void updateSearchQuery(String query) {
    filteredCategories.value = featuredRestaurants
        .where((restaurant) =>
            restaurant['name'].toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  Future<void> fetchFavouriteCuisines() async {
    try {
      final token = await getToken();
      if (token == null) {
        throw Exception("Unauthorized: Token not found");
      }
      final response = await http.get(
        Uri.parse("http://api.dailyfairdeal.com/api/favorite-cuisine"),
        headers: {"Content-Type": "application/json", 'Authorization': 'Bearer $token',},
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        favoriteCuisines.value = data['data'];
      } else if (response.statusCode == 401) {
        Get.snackbar("Error", "Unauthorized access.", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
      } else {
        Get.snackbar("Error", "Failed to load data.", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
    }
  }

  Future<void> fetchPopularItems() async {
    try {
      final token = await getToken();
      if (token == null) {
        throw Exception("Unauthorized: Token not found");
      }
      final response = await http.get(Uri.parse('http://api.dailyfairdeal.com/api/popular-foods'),
        headers: {"Content-Type": "application/json", 'Authorization': 'Bearer $token',},
      );
      if (response.statusCode == 200) {
        popularItems.value = jsonDecode(response.body);
      }
      else if (response.statusCode == 401) {
        Get.snackbar("Error", "Unauthorized access.", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
      } else {
        Get.snackbar("Error", "Failed to load data.", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
      }
    }catch (e) {
      Get.snackbar("Error", "An error occurred: $e", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
    } 
  }

  Future<void> fetchFavoriteCuisines() async {
    try {
      final token = await getToken();
      if (token == null) {
        throw Exception("Unauthorized: Token not found");
      }
      final response = await http.get(Uri.parse('http://api.dailyfairdeal.com/api/favorite-cuisine'),
        headers: {"Content-Type": "application/json", 'Authorization': 'Bearer $token',},
      );
      if (response.statusCode == 200) {
        popularItems.value = jsonDecode(response.body);
      }
      else if (response.statusCode == 401) {
        Get.snackbar("Error", "Unauthorized access.", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
      } else {
        Get.snackbar("Error", "Failed to load data.", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
      }
    }catch (e) {
      Get.snackbar("Error", "An error occurred: $e", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
    } 
  }

    Future<void> fetchOrderAgain() async {
    try {
      final token = await getToken();
      if (token == null) {
        throw Exception("Unauthorized: Token not found");
      }
      final response = await http.get(Uri.parse('http://api.dailyfairdeal.com/api/order-it-again'),
        headers: {"Content-Type": "application/json", 'Authorization': 'Bearer $token',},
      );
      if (response.statusCode == 200) {
        popularItems.value = jsonDecode(response.body);
      }
      else if (response.statusCode == 401) {
        Get.snackbar("Error", "Unauthorized access.", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
      } else {
        Get.snackbar("Error", "Failed to load data.", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
      }
    }catch (e) {
      Get.snackbar("Error", "An error occurred: $e", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
    } 
  }

  void updateCategory(String category) {
    selectedCategory.value = category;
  }

}

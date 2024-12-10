import 'dart:convert'; // For jsonDecode
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

class APIMethods extends GetxController {
  
  Future<List<Map<String, String>>> getCountries() async {
    try {
      final response = await http.get(
        Uri.parse("http://api.dailyfairdeal.com/api/country"),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // Parse the response body into a list of countries
        final data = json.decode(response.body);
        final List<Map<String, String>> countries = [];
        for (var country in data['data']) {
          countries.add({
            'id': country['id'],
            'name': country['name'],
          });
        }
        return countries;
      } else if (response.statusCode == 401) {
        // Handle unauthorized error
        throw Exception("Unauthorized: Invalid credentials");
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
      final response = await http.get(
        Uri.parse("http://api.dailyfairdeal.com/api/state/$countryId"),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // Parse the response body into a list of countries
        final data = json.decode(response.body);
        final List<Map<String, String>> divisions = [];
        for (var division in data['data']) {
          divisions.add({
            'id': division['id'],
            'countryId': division['country_id'],
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
      final response = await http.get(
        Uri.parse("http://api.dailyfairdeal.com/api/city/$divisionId"),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // Parse the response body into a list of countries
        final data = json.decode(response.body);
        final List<Map<String, String>> cities = [];
        for (var city in data['data']) {
          cities.add({
            'id': city['id'],
            'divisionId': city['state_id'],
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
      final response = await http.get(
        Uri.parse("http://api.dailyfairdeal.com/api/township/$cityId"),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // Parse the response body into a list of countries
        final data = json.decode(response.body);
        final List<Map<String, String>> townships = [];
        for (var township in data['data']) {
          townships.add({
            'id': township['id'],
            'cityId': township['city_id'],
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
      final response = await http.get(
        Uri.parse("http://api.dailyfairdeal.com/api/ward/$townshipId"),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // Parse the response body into a list of countries
        final data = json.decode(response.body);
        final List<Map<String, String>> wards = [];
        for (var ward in data['data']) {
          wards.add({
            'id': ward['id'],
            'townshipId': ward['township_id'],
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
      final response = await http.get(
        Uri.parse("http://api.dailyfairdeal.com/api/street/$wardId"),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // Parse the response body into a list of countries
        final data = json.decode(response.body);
        final List<Map<String, String>> streets = [];
        for (var street in data['data']) {
          streets.add({
            'id': street['id'],
            'wardId': street['ward_id'],
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

  Future<List<Map<String, dynamic>>> searchItemsByType(
      String query, String type) async {
    try {
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

  Future<int?> login(String email, String password) async {
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

      return response.statusCode;
    } catch (e) {
      // Handle any exceptions
      return 0;
    }
  }

  Future<int?> register(String name, String email, String password) async {
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
      return response.statusCode;
    } catch (e) {
      // Handle any exceptions
      return 0;
    }
  }

  
  // Fetch Feature and Popular Restaurant

  var currentCategory = 'featured'.obs;

  var filteredCategories = <Map<String, String>>[].obs;
  var popularItems = <Map<String, String>>[].obs;

  // Fetch data methods
  void fetchFeaturedRestaurants() {
    // Simulate API call
    filteredCategories.value = [
      {
        'image': "assets/images/res1.jpg",
        'name': 'The Gourmet Spot',
        'description': 'Fine dining restaurant'
      },
      {
        'image': "assets/images/res2.png",
        'name': 'Pizza Paradise',
        'description': 'Delicious pizzas'
      },
    ];
  }

  void fetchPopularItems() {
    // Simulate API call
    popularItems.value = [
      {
        'image': "assets/images/res3.png",
        'name': 'Burger Bliss',
        'description': 'Juicy burgers'
      },
      {
        'image': "assets/images/res4.jpg",
        'name': 'Sushi Haven',
        'description': 'Fresh sushi'
      },
    ];
  }

  // Update category
  void updateCategory(String category) {
    currentCategory.value = category;
    if (category == 'featured') {
      fetchFeaturedRestaurants();
    } else if (category == 'popular') {
      fetchPopularItems();
    }
  }

  // Handle search query
  void updateSearchQuery(String query) {
    // Simulate filtering logic
    if (currentCategory.value == 'featured') {
      filteredCategories.value = filteredCategories
          .where((item) =>
              item['name']!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } else if (currentCategory.value == 'popular') {
      popularItems.value = popularItems
          .where((item) =>
              item['name']!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }
}

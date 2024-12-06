import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dailyfairdeal/service/api_method.dart';
import 'package:dailyfairdeal/widget/app_color.dart';
import 'package:dailyfairdeal/widget/support_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> searchResults = [];
  bool isLoading = false;

  Future<void> searchItems(String query) async {
    if (query.isEmpty) {
      setState(() {
        searchResults.clear();
      });
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final Uri url = Uri.parse("http://api.dailyfairdeal.com/api/search")
          .replace(queryParameters: {'q': query});

      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          searchResults = data.map((e) => e as Map<String, dynamic>).toList();
        });
      } else {
        print("Error: Received status code ${response.statusCode}");
        setState(() {
          searchResults.clear();
        });
      }
    } catch (e) {
      print("Exception: $e");
      setState(() {
        searchResults.clear();
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.primaryColor,
        flexibleSpace: Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Image.asset("images/logo.png", height: 40),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Material(
                elevation: 8.0,
                shadowColor: Colors.grey.withOpacity(0.6),
                borderRadius: BorderRadius.circular(50.0),
                child: TextFormField(
                  onFieldSubmitted: (query) {
                    searchItems(query);
                  },
                  controller: _searchController,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(10.0),
                    hintText: "Search.....",
                    prefixIcon:
                        Icon(Icons.search, color: AppColor.primaryColor),
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10.0),

            // Display Search Results
            if (isLoading)
              const CircularProgressIndicator()
            else if (searchResults.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: searchResults.map<Widget>((item) {
                    return ListTile(
                      title: Text(item['name'] ?? 'Unknown Item'),
                      subtitle: Text(item['created_at'] ?? 'No date'),
                    );
                  }).toList(),
                ),
              )
            else
              const Text("No results found.", style: TextStyle(fontSize: 16)),

            const SizedBox(height: 30.0),

            // Card View
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildCard("Taxi", Icons.car_crash, AppColor.primaryColor,
                      "/taxicategory"),
                  buildCard("Food", Icons.food_bank_rounded,
                      AppColor.primaryColor, "/foodcategory"),
                  buildCard("Mall", Icons.shop, AppColor.primaryColor,
                      "/mallcategory"),
                  buildCard("All", Icons.more_horiz, AppColor.primaryColor,
                      "allcategory"),
                ],
              ),
            ),
            const SizedBox(height: 30.0),

            // Carousel Slider
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Carousel Ad",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  CarouselSlider(
                    items: [
                      buildCarouselItem("assets/images/food1.jpeg"),
                      buildCarouselItem("assets/images/food2.jpeg"),
                      buildCarouselItem("assets/images/dfd.png"),
                    ],
                    options: CarouselOptions(
                      height: 180.0,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      viewportFraction: 0.8,
                      autoPlayInterval: const Duration(seconds: 3),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            // Two Row Card View
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "Explore Categories",
                    style: AppWidget.carouselTextStyle(),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          //crossAxisSpacing: 20.0,
                          //mainAxisSpacing: 4.0,
                          //childAspectRatio: 1.1,
                        ),
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          final titles = ["Food1", "Food2", "Food3", "Food4"];
                          final icons = [
                            Icons.hotel,
                            Icons.spa,
                            Icons.event,
                            Icons.movie,
                          ];
                          return buildTwoCard(titles[index], icons[index],
                              AppColor.primaryColor);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildCard(String title, IconData icon, Color color, String route) {
  return GestureDetector(
    onTap: () {
      Get.toNamed(route);
    },
    // child: GestureDetector(
    //   onTap: () {
    //     print("Navigating to $title");
    //   },
    child: Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.yellow[50],
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child: Icon(icon, color: color, size: 30),
          ),
        ),
        const SizedBox(height: 10.0),
        Text(title,
            style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 14.0)),
      ],
    ),
  );
}

Widget buildCarouselItem(String imagePath) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(10.0),
    child: Image.asset(
      imagePath,
      fit: BoxFit.cover,
      width: double.infinity,
    ),
  );
}

//Widget build two rows card
Widget buildTwoCard(String title, IconData icon, Color color) {
  return Column(
    children: [
      // Card with Centered Icon
      Container(
        width: 150, // Fixed width for the circular shape
        height: 140, // Fixed height for the circular shape
        decoration: BoxDecoration(
          color: Colors.yellow[50],
          shape: BoxShape.rectangle, // Ensures the card is circular
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 2,
              offset: const Offset(0, 3), // Shadow position
            ),
          ],
        ),
        child: Center(
          child: Icon(
            icon,
            color: color,
            size: 50, // Icon size fits within the smaller circle
          ),
        ),
      ),

      // Text Below the Card
      const SizedBox(height: 10.0),
      Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 14.0, // Slightly smaller font for compact layout
        ),
        textAlign: TextAlign.center,
      ),
    ],
  );
}

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dailyfeardeal/widget/app_color.dart';
import 'package:dailyfeardeal/widget/support_widget.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.primaryColor,
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
                child: const TextField(
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10.0),
                      hintText: "Search.....",
                      prefixIcon: Icon(Icons.search),
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),

            // Card View
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildCard("Taxi", Icons.car_crash, AppColor.primaryColor),
                      buildCard("Food", Icons.food_bank_rounded,
                          AppColor.primaryColor),
                      buildCard("Mall", Icons.shop, AppColor.primaryColor),
                      buildCard("All", Icons.more_horiz, AppColor.primaryColor),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),

            // Carousel Slider
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "Carousel Ad",
                    style: AppWidget.carouselTextStyle(),
                  ),
                ),
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: CarouselSlider(
                      items: [
                        buildCarouselItem("assets/images/food1.jpeg"),
                        buildCarouselItem("assets/images/food2.jpeg"),
                        buildCarouselItem("assets/images/dfd.png"),
                      ],
                      options: CarouselOptions(
                        height: 180.0,
                        enlargeCenterPage: true,
                        autoPlay: true,
                        aspectRatio: 16 / 9,
                        viewportFraction: 0.8,
                        autoPlayInterval: const Duration(seconds: 3),
                      )),
                ),
                const SizedBox(
                  height: 20.0,
                ),
              ],
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

  // Widget to Build Card
  Widget buildCard(String title, IconData icon, Color color) {
    return Column(
      children: [
        // Card with Centered Icon
        Container(
          width: 60, // Fixed width for the circular shape
          height: 60, // Fixed height for the circular shape
          decoration: BoxDecoration(
            color: Colors.yellow[50],
            shape: BoxShape.circle, // Ensures the card is circular
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3), // Shadow position
              ),
            ],
          ),
          child: Center(
            child: Icon(
              icon,
              color: color,
              size: 30, // Icon size fits within the smaller circle
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

  // Widget to Build Carousel Slider
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
}

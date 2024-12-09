import 'package:carousel_slider/carousel_slider.dart';
import 'package:dailyfairdeal/widget/app_color.dart';
import 'package:dailyfairdeal/widget/support_widget.dart';
import 'package:flutter/material.dart';

class FoodPage extends StatefulWidget {
  const FoodPage({super.key});

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  String selectedCategory = '';

  // Demo data
  final List<Map<String, dynamic>> featuredRestaurants = [
    {'image_url': 'https://via.placeholder.com/150', 'name': 'Pizza Hut', 'waiting_time': '30 mins', 'delivery_fee': 5, 'rating': 4.5},
    {'image_url': 'https://via.placeholder.com/150', 'name': 'Subway', 'waiting_time': '20 mins', 'delivery_fee': 3, 'rating': 4.2},
  ];

  final List<Map<String, dynamic>> popularItems = [
    {'image_url': 'https://via.placeholder.com/150', 'food_name': 'Cheeseburger', 'food_type': 'Fast Food', 'rating': 4.3},
    {'image_url': 'https://via.placeholder.com/150', 'food_name': 'Fried Chicken', 'food_type': 'Fast Food', 'rating': 4.1},
  ];

  final List<Map<String, dynamic>> favoriteCuisines = [
    {'images': [{'upload_url': 'https://via.placeholder.com/150'}], 'food-name': 'Italian'},
    {'images': [{'upload_url': 'https://via.placeholder.com/150'}], 'food-name': 'Chinese'},
  ];

  final List<Map<String, dynamic>> orderAgain = [
    {'image_url': 'https://via.placeholder.com/150', 'restaurant_name': 'KFC', 'restaurant_type': 'Fast Food', 'waiting_time': '15 mins', 'delivery_fee': 2, 'rating': 4.0},
    {'image_url': 'https://via.placeholder.com/150', 'restaurant_name': 'McDonalds', 'restaurant_type': 'Fast Food', 'waiting_time': '25 mins', 'delivery_fee': 4, 'rating': 4.3},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        title: Text('Food Page', style: AppWidget.appBarTextStyle(),),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Scrollable Row of Buttons
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildCategoryButton('Featured Restaurants', () {
                    setState(() {
                      selectedCategory = 'featured';
                    });
                  }),
                  _buildCategoryButton('Popular Items', () {
                    setState(() {
                      selectedCategory = 'popular';
                    });
                  }),
                  _buildCategoryButton('Your Favourite Cuisines', () {
                    setState(() {
                      selectedCategory = 'cuisines';
                    });
                  }),
                  _buildCategoryButton('Order It Again', () {
                    setState(() {
                      selectedCategory = 'order';
                    });
                  }),
                ],
              ),
            ),
          ),

          // Dynamic Content
          Expanded(
            child: Builder(
              builder: (context) {
                switch (selectedCategory) {
                  case 'featured':
                    return _buildFeaturedRestaurants(featuredRestaurants);
                  case 'popular':
                    return _buildPopularItems(popularItems);
                  case 'cuisines':
                    return _buildFavoriteCuisines(favoriteCuisines);
                  case 'order':
                    return _buildOrderAgain(orderAgain);
                  default:
                    return const Center(child: Text("Select a category to view items."));
                }
              },
            ),
          ),
        ],
      ),
    );
  }

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

  Widget _buildFeaturedRestaurants(List restaurants) {
    return ListView.builder(
      itemCount: restaurants.length,
      itemBuilder: (context, index) {
        final restaurant = restaurants[index];
        return ListTile(
          leading: Image.network(
            restaurant['image_url'],
            width: 150,
            height: 150,
          ),
          title: Text(
            restaurant['name'],
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),  
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Waiting Time: ${restaurant['waiting_time']}"),
              Text("Delivery Fee: \$${restaurant['delivery_fee']}"),
              Text("Rating: ${restaurant['rating']}"),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPopularItems(List items) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return ListTile(
          leading: Image.network(
            item['image_url'],
            width: 150,
            height: 150,  
          ),
          title: Text(
            item['food_name'],
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),  
          ),
          subtitle: Text(item['food_type']),
          trailing: Text("Rating: ${item['rating']}"),
        );
      },
    );
  }

  Widget _buildFavoriteCuisines(List cuisines) {
    return CarouselSlider.builder(
      itemCount: cuisines.length,
      itemBuilder: (context, index, realIndex) {
        final cuisine = cuisines[index];
        return Column(
          children: [
            Image.network(
              cuisine['images'][0]['upload_url'],
            ),
            Text(cuisine['food-name']),
          ],
        );
      },
      options: CarouselOptions(
        height: 250,
        autoPlay: true,
        enlargeCenterPage: true,
      ),
    );
  }

  Widget _buildOrderAgain(List orders) {
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return ListTile(
          leading: Image.network(order['image_url']),
          title: Text(order['restaurant_name']),
          subtitle: Text(order['restaurant_type']),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Rating: ${order['rating']}"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Waiting Time: ${order['waiting_time']}"),
                  Text("Delivery Fee: \$${order['delivery_fee']}"),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

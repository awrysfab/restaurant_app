import 'package:flutter/material.dart';
import 'package:news_app/restaurant.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail';
  final Restaurant restaurant;
  const RestaurantDetailPage({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(restaurant.pictureId),
            Padding(padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  restaurant.name,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                Row(
                  children: [
                    const Icon(Icons.location_pin),
                    SizedBox(height: 8.0),
                    Text(
                      restaurant.city.toString(),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.star),
                    SizedBox(height: 8.0),
                    Text(
                      restaurant.rating.toString(),
                    ),
                  ],
                ),
                const Divider(color: Colors.grey),
                const Text('Description', style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),),
                const SizedBox(height: 10),
                Text(restaurant.description),
                const Divider(color: Colors.grey),
                const Text('Foods', style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),),
                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: restaurant.menu.foods.map((e) => Text('• ${e['name'].toString()}')).toList(),
                ),
                const Divider(color: Colors.grey),
                const Text('Drinks', style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),),
                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: restaurant.menu.drinks.map((e) => Text('• ${e['name'].toString()}')).toList(),
                ),
              ],
            ),)
          ],
        ),
      ),
    );
  }
}
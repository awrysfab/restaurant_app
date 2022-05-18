import 'package:flutter/material.dart';
import 'package:news_app/restaurant.dart';
import 'package:news_app/detail_page.dart';

class RestaurantsListPage extends StatefulWidget{
  static const routeName = '/restaurant_list';
  const RestaurantsListPage({Key? key}) : super(key: key);

  @override
  _RestaurantsListPageState createState() => _RestaurantsListPageState();
}

class _RestaurantsListPageState extends State<RestaurantsListPage>{
  TextEditingController editingController = TextEditingController();
  String searchString = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Builder(
            builder: (BuildContext context) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                        text: "Restaurant",
                        style: TextStyle(fontSize: 24),
                        children: <TextSpan>[
                          TextSpan(
                            text: '\nRecommendation restaurant for you!',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ]
                    ),
                  ),
                  TextField(
                    onChanged: (value) {
                      setState((){
                        searchString = value;
                      });
                    },
                    controller: editingController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: FutureBuilder<String>(
                        future: DefaultAssetBundle.of(context).loadString('/local_restaurant.json'),
                        builder: (context, snapshot){
                          final List<Restaurant> restaurants = parseRestaurants(snapshot.data);
                          return ListView.builder(
                            itemCount: restaurants.length,
                            itemBuilder: (context, index) {
                              return restaurants[index].name.toLowerCase().contains(searchString.toLowerCase())? _buildRestaurantItem(context, restaurants[index]) : const Text('');
                            },
                          );
                        }
                    ),
                  ),
                ],
              );
            }
        )
    );
  }
}

Widget _buildRestaurantItem(BuildContext context, Restaurant restaurant) {
  return ListTile(
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    leading: Image.network(
      restaurant.pictureId,
      width: 100,
    ),
    title: Text(restaurant.name),
    subtitle: Column(
      children: [
        Row(
          children: [
            const Icon(Icons.location_pin, size: 14.0,),
            Text(restaurant.city),
          ],
        ),
        Row(
          children: [
            const Icon(Icons.star, size: 14.0,),
            Text(restaurant.rating.toString()),
          ],
        )
      ],
    ),
    onTap: (){
      Navigator.pushNamed(context, RestaurantDetailPage.routeName,
          arguments: restaurant);
    },
  );
}
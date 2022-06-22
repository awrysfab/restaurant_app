import 'package:flutter/material.dart';
import 'package:news_app/api/restaurant_detail.dart';

import 'api/api_service.dart';

class RestaurantDetailPage extends StatefulWidget {
  static const routeName = '/restaurant_detail';
  final String id;
  const RestaurantDetailPage({required this.id});

  @override
  _RestaurantsDetailPageState createState() => _RestaurantsDetailPageState();
}

class _RestaurantsDetailPageState extends State<RestaurantDetailPage>{
  TextEditingController editingController = TextEditingController();
  String searchString = "";
  late Future<RestaurantDetail> _restaurant;

  @override
  void initState() {
    super.initState();
    _restaurant = ApiService().restaurantDetail(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Builder(
            builder: (BuildContext context) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
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
                    child: FutureBuilder<RestaurantDetail>(
                        future: _restaurant,
                        builder: (context, snapshot){
                          var state = snapshot.connectionState;
                          if(state != ConnectionState.done){
                            return Center(child: CircularProgressIndicator());
                          }else {
                            if(snapshot.hasData){
                              var restaurant = snapshot.data?.restaurant;
                              return SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Image.network('https://restaurant-api.dicoding.dev/images/medium/' + restaurant!.pictureId),
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
                                          const Text('Categories', style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),),
                                          const SizedBox(height: 10),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: restaurant.categories.map((e) => Text('• ${e.name.toString()}')).toList(),
                                          ),
                                          const Divider(color: Colors.grey),
                                          const Text('Foods', style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),),
                                          const SizedBox(height: 10),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: restaurant.menus.foods.map((e) => Text('• ${e.name.toString()}')).toList(),
                                          ),
                                          const Divider(color: Colors.grey),
                                          const Text('Drinks', style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),),
                                          const SizedBox(height: 10),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: restaurant.menus.drinks.map((e) => Text('• ${e.name.toString()}')).toList(),
                                          ),
                                        ],
                                      ),)
                                  ],
                                ),
                              );
                            } else if(snapshot.hasError){
                              return Center(child: Text(snapshot.error.toString()));
                            }else {
                              return Text('');
                            }
                          }
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
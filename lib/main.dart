import 'package:flutter/material.dart';
import 'package:news_app/api/api_service.dart';
import 'package:news_app/api/restaurant_list.dart';
import 'package:news_app/detail_page.dart';
import 'package:news_app/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurants App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
      initialRoute: Splash.routeName,
      routes: {
        Splash.routeName: (context) => Splash(),
        RestaurantsListPage.routeName: (context) => RestaurantsListPage(),
        RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
            id: ModalRoute.of(context)?.settings.arguments as String,
        ),
      },
    );
  }
}

class RestaurantsListPage extends StatefulWidget{
  static const routeName = '/restaurant_list';
  const RestaurantsListPage({Key? key}) : super(key: key);

  @override
  _RestaurantsListPageState createState() => _RestaurantsListPageState();
}

class _RestaurantsListPageState extends State<RestaurantsListPage>{
  TextEditingController editingController = TextEditingController();
  String searchString = "";
  late Future<RestaurantList> _restaurant;


  @override
  void initState() {
    super.initState();
    _restaurant = ApiService().restaurantList();
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
                    child: FutureBuilder<RestaurantList>(
                        future: _restaurant,
                        builder: (context, snapshot){
                          var state = snapshot.connectionState;
                          if(state != ConnectionState.done){
                            return Center(child: CircularProgressIndicator());
                          }else {
                            if(snapshot.hasData){
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data?.restaurants.length,
                                itemBuilder: (context, index) {
                                  var restaurants = snapshot.data?.restaurants[index];
                                  if(restaurants!.name.toLowerCase().contains(searchString.toLowerCase())){
                                    return _buildRestaurantItem(context, restaurants!);
                                  } else {
                                    return Text('');
                                  }
                                  },
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

Widget _buildRestaurantItem(BuildContext context, Restaurant restaurant) {
  return ListTile(
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    leading: Image.network(
      'https://restaurant-api.dicoding.dev/images/small/' + restaurant.pictureId,

      width: 100,
    ),
    title: Text(restaurant.name),
    subtitle: Text(restaurant.city),
    onTap: (){
      Navigator.pushNamed(context, RestaurantDetailPage.routeName,
          arguments: restaurant.id);
    },
  );
}
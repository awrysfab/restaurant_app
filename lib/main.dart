import 'package:flutter/material.dart';
import 'package:news_app/restaurant.dart';
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
            restaurant: ModalRoute.of(context)?.settings.arguments as Restaurant,
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
                    child: FutureBuilder<String>(
                        future: DefaultAssetBundle.of(context).loadString('/restaurants.json'),
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
    subtitle: Text(restaurant.city),
    onTap: (){
      Navigator.pushNamed(context, RestaurantDetailPage.routeName,
          arguments: restaurant);
    },
  );
}
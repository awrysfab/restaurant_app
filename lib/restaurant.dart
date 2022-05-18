import 'dart:convert';

class Food {
  String name;
  Food(
    this.name,
  );
  factory Food.fromJson(dynamic food){
    return Food(food['name']);
  }
}

class Drink {
  String name;
  Drink(
    this.name,
  );
  factory Drink.fromJson(dynamic drink){
    return Drink(drink['name']);
  }
}

class Menu {
  List foods;
  List drinks;
  Menu(
    this.foods,
    this.drinks
  );
  factory Menu.fromJson(dynamic menu){
    return Menu(
      menu['foods'],
      menu['drinks'],
    );
  }
}

class Restaurant {
  String id;
  String name;
  String description;
  String pictureId;
  String city;
  double rating;
  Menu menu;

  Restaurant(
    this.id,
    this.name,
    this.description,
    this.pictureId,
    this.city,
    this.rating,
    this.menu,
  );

  factory Restaurant.fromJson(dynamic restaurant){
    return Restaurant(
        restaurant['id'],
        restaurant['name'],
        restaurant['description'],
        restaurant['pictureId'],
        restaurant['city'],
        restaurant['rating'],
        Menu.fromJson(restaurant['menus']),
    );
  }
}

List<Restaurant> parseRestaurants(String? json){
  if(json == null){
    return [];
  }
  final List parsed = jsonDecode(json);
  return parsed.map((json) => Restaurant.fromJson(json)).toList();
}
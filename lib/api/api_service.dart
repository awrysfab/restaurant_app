import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/api/restaurant_list.dart';
import 'package:news_app/api/restaurant_detail.dart';

class ApiService {
  static final String _baseUrl = 'https://restaurant-api.dicoding.dev/';

  Future<RestaurantList> restaurantList() async {
    final response = await http.get(Uri.parse(_baseUrl + "list"));
    if(response.statusCode == 200){
      return RestaurantList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<RestaurantDetail> restaurantDetail(String id) async {
    final response = await http.get(Uri.parse(_baseUrl + "detail/" + id));
    if(response.statusCode == 200){
      return RestaurantDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }
}

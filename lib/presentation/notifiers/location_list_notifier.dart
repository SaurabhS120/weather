import 'package:flutter/material.dart';
import 'package:weather/presentation/item/city_item.dart';
import 'package:weather/presentation/item/weather_item.dart';

class LocationListNotifier extends ChangeNotifier {
  List<CityItem> city_list = [];
  List<WeatherItem> weather_item = [];

  void update(List<CityItem> _city_list, List<WeatherItem> _weather_item) {
    this.city_list = _city_list;
    this.weather_item = _weather_item;
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:weather/presentation/item/city_item.dart';
import 'package:weather/presentation/item/hourly_weather_data_item.dart';
import 'package:weather/presentation/item/unit_item.dart';
import 'package:weather/presentation/item/weather_item.dart';

class WeatherNotifier extends ChangeNotifier {
  var weatherItem = WeatherItem("", 0, 0, 0, 0, 0, 0, '', '');
  var hourlyWeatherItem = HourlyWeatherDataItem([]);
  UnitItem unit = UnitItem(MetricUnitItem());
  CityItem? cityItem = null;

  void updateWeatherItem(WeatherItem weatherItem) {
    this.weatherItem = weatherItem;
    notifyListeners();
  }

  void updateHourlyWeatherItem(HourlyWeatherDataItem hourlyWeatherItem) {
    this.hourlyWeatherItem = hourlyWeatherItem;
    notifyListeners();
  }
}

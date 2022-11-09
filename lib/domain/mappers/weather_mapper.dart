import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather/domain/model/weather_model.dart';
import 'package:weather/presentation/item/weather_item.dart';

extension WeatherItemMapper on WeatherItem {
  WeatherModel toModel() => WeatherModel(
      date, temp, feelsLike, tempMax, tempMin, pressure, humidity, icon, main);
}

extension WeatherModelMapper on WeatherModel {
  WeatherItem toItem() {
    Color color = Colors.grey;
    switch (main.toLowerCase()) {
      case 'sunny':
        color = Colors.orange;
        break;
      case 'rain':
        color = Colors.blue;
        break;
      case 'clouds':
        color = Colors.lightBlueAccent;
        break;
    }
    return WeatherItem(date, temp, feelsLike, tempMax, tempMin, pressure,
        humidity, icon, main);
  }
}

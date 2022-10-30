import 'package:flutter/material.dart';
import 'package:weather/domain/entity/weather_entity.dart';
abstract class WeatherDataRepo{
  Future<WeatherEntity> getWeatherData();
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/domain/mappers/city_mapper.dart';
import 'package:weather/domain/usecase/hourly_weather_data_usecase.dart';
import 'package:weather/domain/usecase/weather_data_usecase.dart';
import 'package:weather/presentation/item/city_item.dart';
import 'package:weather/presentation/item/hourly_weather_data_item.dart';
import 'package:weather/presentation/item/weather_item.dart';
import 'package:weather/presentation/notifiers/weather_notifier.dart';
class WeatherController extends GetxController {
  var weather_notifier = WeatherNotifier();

  HourlyWeatherDataUseCase hourlyWeatherDataUseCase;
  WeatherDataUsecase weatherDataUsecase;

  WeatherController(this.weatherDataUsecase, this.hourlyWeatherDataUseCase);

  set(CityItem cityItem) {
    weather_notifier.cityItem = cityItem;
    getWeather();
    getHourlyWeather();
  }

  @override
  void onInit() {
    super.onInit();
  }

  void getWeather() async {
    if (weather_notifier.cityItem == null) {
      print('No cities passed to fetch');
    } else {
      WeatherItem weatherItem = await weatherDataUsecase.invoke(
          weather_notifier.cityItem!, weather_notifier.unit.unit.getUnitName());
      weather_notifier.updateWeatherItem(weatherItem);
    }
  }

  void getHourlyWeather() async {
    if (weather_notifier.cityItem == null) {
      print('No cities passed to fetch');
    } else {
      HourlyWeatherDataItem hourlyWeatherItem =
          await hourlyWeatherDataUseCase.invoke(
              weather_notifier.cityItem!.toModel(),
              weather_notifier.unit.unit.getUnitName());
      weather_notifier.updateHourlyWeatherItem(hourlyWeatherItem);
    }
  }

  toggleUnit() {
    weather_notifier.unit = weather_notifier.unit.toggle();
    // weather_notifier.notifyListeners();
    getWeather();
    getHourlyWeather();
  }

  Image imageForMain(String main,
      {required double height, required double width, required Color color}) {
    String asset = 'images/sunny.png';
    switch (main.toLowerCase()) {
      case 'rain':
        asset = 'images/rain.png';
        break;
      case 'sunny':
        asset = 'images/sunny.png';
        break;
      case 'clouds':
        asset = 'images/cloud.png';
        break;
      case 'clear':
        asset = 'images/sunny.png';
        break;
      case 'snow':
        asset = 'images/snow.png';
        break;
    }
    return Image.asset(
      asset,
      height: height,
      width: width,
      color: color,
    );
  }

  Color getColorForMain(String main) {
    Color color = Colors.grey;
    switch (main.toLowerCase()) {
      case 'rain':
        color = Colors.black54;
        break;
      case 'sunny':
        color = Colors.orange;
        break;
      case 'clouds':
        color = Colors.lightBlue;
        break;
      case 'clear':
        color = Color.fromRGBO(138, 226, 255, 1.0);
        break;
      case 'snow':
        color = Color.fromRGBO(224, 224, 224, 1.0);
        break;
    }
    return color;
  }

  Color getGradientStartColorForMain(String main) {
    Color color = Color.fromRGBO(229, 229, 229, 1.0);
    switch (main.toLowerCase()) {
      case 'rain':
        color = Color.fromRGBO(66, 84, 206, 1.0);
        break;
      case 'sunny':
        color = Color.fromRGBO(243, 165, 61, 1.0);
        break;
      case 'clouds':
        color = Color.fromRGBO(64, 192, 255, 1.0);
        break;
      case 'clear':
        color = Color.fromRGBO(164, 71, 183, 1.0);
        break;
      case 'snow':
        color = Color.fromRGBO(224, 224, 224, 1.0);
        break;
    }
    return color;
  }

  Color getGradientEndColorForMain(String main) {
    Color color = Colors.grey;
    switch (main.toLowerCase()) {
      case 'rain':
        color = Color.fromRGBO(9, 22, 152, 1.0);
        break;
      case 'sunny':
        color = Color.fromRGBO(255, 140, 41, 1.0);
        break;
      case 'clouds':
        color = Colors.lightBlue;
        break;
      case 'clear':
        color = Color.fromRGBO(127, 23, 157, 1.0);
        break;
      case 'snow':
        color = Color.fromRGBO(201, 201, 201, 1.0);
        break;
    }
    return color;
  }

  Color getTextColorForMain(String main) {
    Color color = Colors.white;
    switch (main.toLowerCase()) {
      case 'snow':
        color = Colors.black54;
        break;
    }
    return color;
  }

  void init() {
    weather_notifier = WeatherNotifier();
  }
}

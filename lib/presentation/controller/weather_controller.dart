import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/domain/mappers/city_mapper.dart';
import 'package:weather/domain/usecase/hourly_weather_data_usecase.dart';
import 'package:weather/domain/usecase/weather_data_usecase.dart';
import 'package:weather/presentation/item/city_item.dart';
import 'package:weather/presentation/item/hourly_weather_data_item.dart';
import 'package:weather/presentation/item/unit_item.dart';
import 'package:weather/presentation/item/weather_item.dart';

class WeatherController extends GetxController {
  final cityItem = Rx<CityItem?>(null);
  Rx<UnitItem> unit = UnitItem(MetricUnitItem()).obs;

  set(CityItem cityItem) {
    _isLoading.value = true;
    this.cityItem.value = cityItem;
    getWeather();
    getHourlyWeather();
    _isLoading.value = false;
  }

  final _weatherItem = WeatherItem("", 0, 0, 0, 0, 0, 0, '', '').obs;
  final _hourlyWeatherItem = HourlyWeatherDataItem([]).obs;
  final RxBool _isLoading = true.obs;

  RxBool checkLoading() => _isLoading;

  Rx<WeatherItem> getWeatherItem() => _weatherItem;

  Rx<HourlyWeatherDataItem> getHourlyWeatherItem() => _hourlyWeatherItem;

  @override
  void onInit() {
    super.onInit();
  }

  void getWeather() async {
    if (cityItem.value == null) {
      print('No cities passed to fetch');
    } else {
      WeatherDataUsecase weatherDataUsecase = Get.find<WeatherDataUsecase>();
      WeatherItem weatherItem = await weatherDataUsecase.invoke(
          cityItem.value!, unit.value.unit.getUnitName());
      _weatherItem.value = weatherItem;
      _isLoading.value = false;
    }
  }

  void getHourlyWeather() async {
    if (cityItem.value == null) {
      print('No cities passed to fetch');
    } else {
      HourlyWeatherDataUseCase hourlyWeatherDataUseCase =
      Get.find<HourlyWeatherDataUseCase>();
      HourlyWeatherDataItem hourlyWeatherItem = await hourlyWeatherDataUseCase
          .invoke(cityItem.value!.toModel(), unit.value.unit.getUnitName());
      _hourlyWeatherItem.value = hourlyWeatherItem;
      _isLoading.value = false;
    }
  }

  toggleUnit() {
    _isLoading.value = true;
    unit.value = unit.value.toggle();
    getWeather();
    getHourlyWeather();
    _isLoading.value = false;
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
}

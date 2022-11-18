import 'package:flutter/material.dart';
import 'package:weather/domain/mappers/city_mapper.dart';
import 'package:weather/domain/usecase/cities_local_usecase.dart';
import 'package:weather/domain/usecase/hourly_weather_data_usecase.dart';
import 'package:weather/domain/usecase/weather_data_usecase.dart';
import 'package:weather/presentation/item/city_item.dart';
import 'package:weather/presentation/item/hourly_weather_data_item.dart';
import 'package:weather/presentation/item/weather_item.dart';
import 'package:weather/presentation/notifiers/all_weather_details_item.dart';
import 'package:weather/presentation/notifiers/ui_config_notifier.dart';
import 'package:weather/presentation/notifiers/weather_notifier.dart';

class LocationListController {
  final CitiesLocalUseCase citiesLocalUsecase;
  HourlyWeatherDataUseCase hourlyWeatherDataUseCase;
  final WeatherNotifier weatherNotifier = WeatherNotifier();
  final UiConfigNotifier uiNotifier = UiConfigNotifier();

  WeatherDataUsecase weatherDataUsecase;

  LocationListController(this.citiesLocalUsecase, this.weatherDataUsecase,
      this.hourlyWeatherDataUseCase);

  Future<void> getFromDB() async {
    setCities(await citiesLocalUsecase.getCities());
  }

  Future<void> add_city(CityItem cityItem) async {
    await citiesLocalUsecase.addCity(cityItem);
    await updateData();
  }

  void remove(int index) async {
    citiesLocalUsecase.removeCity(weatherNotifier.weathers[index].cityItem!);
    await updateData();
  }

  void setCurrentCity(String s) {
    uiNotifier.currentCity = s;
    uiNotifier.notifyListeners();
  }

  Future<void> getWeathers() async {
    List<WeatherItem> list = [];
    for (var e in weatherNotifier.weathers) {
      try {
        WeatherItem weatherItem = await weatherDataUsecase.invoke(
            e.cityItem!, weatherNotifier.unit.unit.getUnitName());
        list.add(weatherItem);
      } on Exception catch (e) {
        print(e);
      }
    }
    setWeathers(list);
    print("weatherNotifier len : ${weatherNotifier.weathers.length}");
  }

  Future<void> updateData() async {
    await getFromDB();
    await getWeathers();
    await getHourlyWeather();
  }

  void setCities(List<CityItem> cities) {
    this.weatherNotifier.weathers = cities
        .map((e) => AllWeatherDetailsItem(AllWeatherDetailsItem.defaultUnit,
            cityItem: e))
        .toList();
    weatherNotifier.notifyListeners();
  }

  void setWeathers(List<WeatherItem> weathers) {
    for (int i = 0; i < weathers.length; i++) {
      weatherNotifier.weathers[i].weatherItem = weathers[i];
      weatherNotifier.notifyListeners();
    }
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

  toggleUnit() {
    weatherNotifier.unit = weatherNotifier.unit.toggle();
    updateData();
  }

  Future<void> getHourlyWeather() async {
    List<HourlyWeatherDataItem> hourlyWeatherItemList = [];
    for (var weather in weatherNotifier.weathers) {
      if (weather.cityItem == null) {
        print('No cities passed to fetch');
      } else {
        HourlyWeatherDataItem hourlyWeatherItem =
            await hourlyWeatherDataUseCase.invoke(
                weather.cityItem!.toModel(), weather.unit.unit.getUnitName());
        hourlyWeatherItemList.add(hourlyWeatherItem);
      }
    }
    updateHourlyWeatherItems(hourlyWeatherItemList);
  }

  void updateHourlyWeatherItems(
      List<HourlyWeatherDataItem> hourlyWeatherItemList) {
    for (int i = 0; i < hourlyWeatherItemList.length; i++) {
      weatherNotifier.weathers[i].hourlyWeatherItem = hourlyWeatherItemList[i];
    }
    weatherNotifier.notifyListeners();
  }
}

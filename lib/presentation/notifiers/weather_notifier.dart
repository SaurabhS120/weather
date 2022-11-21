import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather/domain/mappers/city_mapper.dart';
import 'package:weather/domain/usecase/cities_local_usecase.dart';
import 'package:weather/domain/usecase/hourly_weather_data_usecase.dart';
import 'package:weather/domain/usecase/weather_data_usecase.dart';
import 'package:weather/presentation/item/city_item.dart';
import 'package:weather/presentation/item/hourly_weather_data_item.dart';
import 'package:weather/presentation/item/unit_item.dart';
import 'package:weather/presentation/item/weather_item.dart';
import 'package:weather/presentation/notifiers/all_weather_details_item.dart';

import '../../di/binding/main_binding.dart';

class WeatherNotifier extends ChangeNotifier {
  UnitItem unit = AllWeatherDetailsItem.defaultUnit;
  List<AllWeatherDetailsItem> weathers = [];

  void addCity(CityItem city) {
    weathers.add(AllWeatherDetailsItem(AllWeatherDetailsItem.defaultUnit,
        cityItem: city));
  }

  toggleUnit() {
    unit = unit.toggle();
    updateData();
  }

  late CitiesLocalUseCase citiesLocalUsecase;
  late HourlyWeatherDataUseCase hourlyWeatherDataUseCase;

  late WeatherDataUsecase weatherDataUsecase;

  WeatherNotifier(MainBinding mainBinding) {
    citiesLocalUsecase = mainBinding.citiesLocalUseCase;
    hourlyWeatherDataUseCase = mainBinding.hourlyWeatherDataUseCase;
    weatherDataUsecase = mainBinding.weatherDataUsecase;
  }

  Future<void> getFromDB() async {
    setCities(await citiesLocalUsecase.getCities());
  }

  Future<void> add_city(CityItem cityItem) async {
    await citiesLocalUsecase.addCity(cityItem);
    await updateData();
  }

  void remove(int index) async {
    await citiesLocalUsecase.removeCity(weathers[index].cityItem!);
    await updateData();
  }

  Future<void> getWeathers() async {
    List<WeatherItem> list = [];
    for (var e in weathers) {
      try {
        WeatherItem weatherItem = await weatherDataUsecase.invoke(
            e.cityItem!, unit.unit.getUnitName());
        list.add(weatherItem);
      } on Exception catch (e) {
        print(e);
      }
    }
    setWeathers(list);
    print("weatherNotifier len : ${weathers.length}");
  }

  Future<void> updateData() async {
    await getFromDB();
    await getWeathers();
    await getHourlyWeather();
    notifyListeners();
  }

  void setCities(List<CityItem> cities) {
    this.weathers = cities
        .map((e) => AllWeatherDetailsItem(AllWeatherDetailsItem.defaultUnit,
            cityItem: e))
        .toList();
    notifyListeners();
  }

  void setWeathers(List<WeatherItem> weathers) {
    for (int i = 0; i < weathers.length; i++) {
      this.weathers[i].weatherItem = weathers[i];
      notifyListeners();
    }
  }

  Future<void> getHourlyWeather() async {
    List<HourlyWeatherDataItem> hourlyWeatherItemList = [];
    for (var weather in weathers) {
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
      weathers[i].hourlyWeatherItem = hourlyWeatherItemList[i];
    }
    notifyListeners();
  }
}
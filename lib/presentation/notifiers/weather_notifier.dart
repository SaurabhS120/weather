import 'package:flutter/cupertino.dart';
import 'package:weather/presentation/item/city_item.dart';
import 'package:weather/presentation/item/unit_item.dart';
import 'package:weather/presentation/notifiers/all_weather_details_item.dart';

class WeatherNotifier extends ChangeNotifier {
  UnitItem unit = AllWeatherDetailsItem.defaultUnit;
  List<AllWeatherDetailsItem> weathers = [];

  void setWeathers(List<AllWeatherDetailsItem> weathers) {
    this.weathers = weathers;
    notifyListeners();
  }

  void addCity(CityItem city) {
    weathers.add(AllWeatherDetailsItem(AllWeatherDetailsItem.defaultUnit,
        cityItem: city));
  }
}
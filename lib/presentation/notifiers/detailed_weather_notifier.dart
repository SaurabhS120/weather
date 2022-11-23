import 'package:flutter/cupertino.dart';
import 'package:weather/domain/usecase/weather_data_usecase.dart';
import 'package:weather/presentation/item/weather_item.dart';

import '../item/city_item.dart';

class DetailedWeatherNotifier extends ChangeNotifier{
  WeatherDataUsecase weatherDataUsecase;
  DetailedWeatherNotifier(this.weatherDataUsecase);
  WeatherItem? weatherItem=null;
  CityItem? city;
  String? metric;
  bool loading = true;

  void updateData()async{
    if(city!=null && metric !=null){
      loading = true;
      notifyListeners();
      weatherItem = await weatherDataUsecase.invoke(city!,metric!);
      loading = false;
      notifyListeners();
    }
  }
}
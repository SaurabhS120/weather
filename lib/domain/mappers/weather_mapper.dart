import 'package:weather/domain/model/weather_model.dart';
import 'package:weather/presentation/item/weather_item.dart';
extension WeatherItemMapper on WeatherItem {
  WeatherModel toModel() =>
      WeatherModel(temp, feelsLike, tempMax, tempMin, pressure, humidity, icon);
}

extension WeatherModelMapper on WeatherModel {
  WeatherItem toItem() =>
      WeatherItem(temp, feelsLike, tempMax, tempMin, pressure, humidity, icon);
}
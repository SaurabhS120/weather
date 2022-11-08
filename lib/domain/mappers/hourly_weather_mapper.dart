import 'package:weather/domain/model/hourly_weather_data_model.dart';
import 'package:weather/presentation/item/hourly_weather_data_item.dart';

extension HourlyWeatherItemMapper on SingleHourDataModel {
  SingleHourDataItem toItem() => SingleHourDataItem(temp, main);
}

extension HourlyWeatherMapper on HourlyWeatherDataModel {
  HourlyWeatherDataItem toItem() =>
      HourlyWeatherDataItem(data.map((e) => e.toItem()).toList());
}

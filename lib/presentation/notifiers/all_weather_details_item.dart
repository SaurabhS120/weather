import 'package:weather/presentation/item/city_item.dart';
import 'package:weather/presentation/item/hourly_weather_data_item.dart';
import 'package:weather/presentation/item/unit_item.dart';
import 'package:weather/presentation/item/weather_item.dart';

class AllWeatherDetailsItem {
  WeatherItem? weatherItem;
  HourlyWeatherDataItem? hourlyWeatherItem;
  UnitItem unit = UnitItem(MetricUnitItem());
  static UnitItem defaultUnit = UnitItem(MetricUnitItem());
  CityItem? cityItem;

  AllWeatherDetailsItem(this.unit,
      {this.weatherItem, this.hourlyWeatherItem, this.cityItem});
}

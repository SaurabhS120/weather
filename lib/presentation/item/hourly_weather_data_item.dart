class HourlyWeatherDataItem {
  List<SingleHourDataItem> data;

  HourlyWeatherDataItem(this.data);
}

class SingleHourDataItem {
  double temp;
  String main;

  SingleHourDataItem(this.temp, this.main);
}

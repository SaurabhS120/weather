class HourlyWeatherDataItem {
  List<SingleHourDataItem> data;

  HourlyWeatherDataItem(this.data);
}

class SingleHourDataItem {
  String time;
  double temp;
  String main;

  SingleHourDataItem(this.time, this.temp, this.main);
}

class HourlyWeatherDataModel {
  List<SingleHourDataModel> data;

  HourlyWeatherDataModel(this.data);
}

class SingleHourDataModel {
  String time;
  double temp;
  String main;

  SingleHourDataModel(this.time, this.temp, this.main);
}

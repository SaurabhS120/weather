class HourlyWeatherDataModel {
  List<SingleHourDataModel> data;

  HourlyWeatherDataModel(this.data);
}

class SingleHourDataModel {
  double temp;
  String main;

  SingleHourDataModel(this.temp, this.main);
}

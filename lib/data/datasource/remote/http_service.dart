import 'package:dio/dio.dart';
import 'package:weather/data/model/city_data_response.dart';
import 'package:weather/data/model/weather_details_model.dart';
import 'package:weather/domain/entity/location_entity.dart';

class HttpService {
  late Dio _dio;
  final String baseUrl = 'https://api.openweathermap.org';

  HttpService() {
    _dio = Dio(
      BaseOptions(baseUrl: baseUrl),
    );
  }

  Future<WeatherDetailsModel> getWeatherDetails(
      LocationEntity locationEntity) async {
    Response response;
    try {
      var data = {
        'lat': locationEntity.lattitude,
        'lon': locationEntity.longitude,
        'appid': '961132958849047de54af9a4a68a8166',
        'units': 'imperial'
      };
      response = await _dio.get('/data/2.5/weather', queryParameters: data);
      print(response);
      WeatherDetailsModel json = WeatherDetailsModel.fromJson(response.data);
      return json;
    } on DioError catch (e) {
      print(e);
      throw Exception(e.message);
    }
  }

  Future<CityDataResponse> getCityNameFromLoc(String cityName) async {
    Response response;
    try {
      var data = {
        'q': cityName,
        'limit': 1,
        'appid': '961132958849047de54af9a4a68a8166',
      };
      response = await _dio.get('/geo/1.0/direct', queryParameters: data);
      print(response);
      CityDataResponse cityDataResponse =
          CityDataResponse.fromJson(response.data[0]);
      print(
          "city = $cityName lat = ${cityDataResponse.lat} long = ${cityDataResponse.lon} ");
      return cityDataResponse;
    } on DioError catch (e) {
      print(e);
      throw Exception(e.message);
    }
  }
}

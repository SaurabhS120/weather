import 'package:dio/dio.dart';
import 'package:weather/data/model/city_data_response.dart';

class LatLongFromCityService {
  late Dio _dio;
  final String baseUrl = 'http://api.openweathermap.org';

  LatLongFromCityService() {
    _dio = Dio(
      BaseOptions(baseUrl: baseUrl),
    );
  }

  Future<CityDataResponse> getRequest(String cityName) async {
    Response response;
    try {
      var data = {
        'q': cityName,
        'limit': 1,
        'appid': '961132958849047de54af9a4a68a8166',
      };
      response = await _dio.get('/direct', queryParameters: data);
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

void main() async {
  var data = await LatLongFromCityService().getRequest('pune');
}

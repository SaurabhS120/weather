import 'package:dio/dio.dart';
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

  Future<WeatherDetailsModel> getRequest(LocationEntity locationEntity) async {
    Response response;
    try {
      var data = {
        'lat': locationEntity.lattitude,
        'lon': locationEntity.longitude,
        'appid': '961132958849047de54af9a4a68a8166',
        'units': 'metric'
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
}

void main() async {
  var data =
      await HttpService().getRequest(LocationEntity(37.4219983, -122.084));
}

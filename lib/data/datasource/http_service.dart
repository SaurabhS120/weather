import 'package:dio/dio.dart';
import 'package:weather/data/model/weather_details_model.dart';
class HttpService{
  late Dio _dio;
  final String base_url = 'https://api.openweathermap.org/data/2.5';
  HttpService(){
    _dio = Dio(
      BaseOptions(baseUrl: base_url),
    );
  }
  Future<WeatherDetailsModel> getRequest() async{
    Response response;
    try{
      var data = {
        'lat':37.4219983,
        'lon':-122.084,
        'appid':'961132958849047de54af9a4a68a8166',
      };
      response = await _dio.get('/weather',queryParameters: data);
      print(response);
      WeatherDetailsModel json = WeatherDetailsModel.fromJson(response.data);
      return json;
    }on DioError catch(e){
      print(e);
      throw Exception(e.message);
    }
  }
}
void main()async{
  var data = await HttpService().getRequest();
}
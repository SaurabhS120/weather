import 'package:weather/domain/model/city_model.dart';

abstract class CitiesLocalRepo {

  Future<void> addCity(CityModel city);

  Future<List<CityModel>> getCities();

  void removeCity(CityModel cityEntity);
}

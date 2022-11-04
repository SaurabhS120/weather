import 'package:weather/domain/entity/city_entity.dart';

abstract class CitiesLocalRepo {
  void init();

  void addCity(CityEntity city);

  Future<List<CityEntity>> getCities();

  void removeCity(CityEntity cityEntity);
}

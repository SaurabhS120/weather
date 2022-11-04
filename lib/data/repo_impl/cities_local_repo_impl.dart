import 'package:weather/data/datasource/local/cities_db.dart';
import 'package:weather/domain/entity/city_entity.dart';
import 'package:weather/domain/repo/cities_local_repo.dart';

class CitiesLocalRepoImpl extends CitiesLocalRepo {
  var cities_db = CitiesDB();

  void addCity(CityEntity city) {
    cities_db.addCity(city);
  }

  Future<List<CityEntity>> getCities() async {
    return await cities_db.getCities();
  }

  @override
  void removeCity(CityEntity cityEntity) {
    cities_db.removeCity(cityEntity.cityName);
  }
}
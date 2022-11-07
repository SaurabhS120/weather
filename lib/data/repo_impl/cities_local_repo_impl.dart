import 'package:weather/data/datasource/local/cities_db.dart';
import 'package:weather/data/mapper/city_mapper.dart';
import 'package:weather/domain/model/city_model.dart';
import 'package:weather/domain/repo/cities_local_repo.dart';

class CitiesLocalRepoImpl extends CitiesLocalRepo {
  var cities_db = CitiesDB();

  void addCity(CityModel city) {
    cities_db.addCity(city.toDbEntity());
  }

  Future<List<CityModel>> getCities() async {
    return (await cities_db.getCities()).toModelList();
  }

  @override
  void removeCity(CityModel cityEntity) {
    cities_db.removeCity(cityEntity.cityName);
  }
}

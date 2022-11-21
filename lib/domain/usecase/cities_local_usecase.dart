import 'package:weather/domain/mappers/city_mapper.dart';
import 'package:weather/domain/repo/cities_local_repo.dart';
import 'package:weather/presentation/item/city_item.dart';

class CitiesLocalUseCase {
  final CitiesLocalRepo citiesLocalRepo;

  CitiesLocalUseCase(this.citiesLocalRepo);

  Future<void> addCity(CityItem city) async =>
      await citiesLocalRepo.addCity(city.toModel());

  Future<List<CityItem>> getCities() async =>
      (await citiesLocalRepo.getCities()).toItemList();

  Future<void> removeCity(CityItem city) async =>
      await citiesLocalRepo.removeCity(city.toModel());
}

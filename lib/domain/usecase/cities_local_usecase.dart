import 'package:get/get.dart';
import 'package:weather/domain/mappers/city_mapper.dart';
import 'package:weather/domain/repo/cities_local_repo.dart';
import 'package:weather/presentation/item/city_item.dart';

class CitiesLocalUseCase {
  final citiesLocalRepo = Get.find<CitiesLocalRepo>();

  void addCity(CityItem city) => citiesLocalRepo.addCity(city.toModel());

  Future<List<CityItem>> getCities() async =>
      (await citiesLocalRepo.getCities()).toItemList();

  void removeCity(CityItem city) => citiesLocalRepo.removeCity(city.toModel());
}

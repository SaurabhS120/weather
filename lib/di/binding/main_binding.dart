import 'package:get/get.dart';
import 'package:weather/data/repo_impl/cities_local_repo_impl.dart';
import 'package:weather/data/repo_impl/city_name_to_lat_lon_geo_loc_repo_impl.dart';
import 'package:weather/data/repo_impl/lat_long_to_city_name_repo_impl.dart';
import 'package:weather/domain/repo/cities_local_repo.dart';
import 'package:weather/domain/repo/city_name_to_lat_lon_geo_loc_repo.dart';
import 'package:weather/domain/repo/lat_long_to_city_name_repo.dart';
import 'package:weather/domain/usecase/lat_long_to_city_name_usecase.dart';
import 'package:weather/domain/usecase/location_from_city_usecase.dart';
import 'package:weather/presentation/controller/geolocation_controller.dart';
import 'package:weather/presentation/controller/location_list_controller.dart';
import 'package:weather/presentation/controller/weather_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    CitiesLocalRepo citiesLocalRepo = CitiesLocalRepoImpl() as CitiesLocalRepo;
    citiesLocalRepo.init();
    Get.lazyPut(() => (CitiesLocalRepoImpl() as CitiesLocalRepo), fenix: true);
    Get.lazyPut(
        () => (CiityNameToLatLonGeoLocRepoImpl() as CityNameToLatLonGeoLocRepo),
        fenix: true);
    Get.lazyPut(() => (LocationFromCityUsecase()), fenix: true);
    Get.lazyPut(() => (WeatherController()), fenix: true);
    Get.lazyPut(() => (LocationListController()), fenix: true);
    Get.lazyPut(() => (LatLongToCityNameRepoImpl() as LatLongToCityNameRepo),
        fenix: true);
    Get.lazyPut(() => (LatLongToCityNameUsecase()), fenix: true);
    Get.lazyPut(() => (GeoLocationController()), fenix: true);
  }
}
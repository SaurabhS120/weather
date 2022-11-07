import 'package:get/get.dart';
import 'package:weather/data/repo_impl/cities_local_repo_impl.dart';
import 'package:weather/data/repo_impl/geocoding_repo_impl.dart';
import 'package:weather/data/repo_impl/open_weather_city_name_repo_impl.dart';
import 'package:weather/data/repo_impl/weather_repo_impl.dart';
import 'package:weather/domain/repo/cities_local_repo.dart';
import 'package:weather/domain/repo/lat_long_to_city_name_repo.dart';
import 'package:weather/domain/repo/location_repo.dart';
import 'package:weather/domain/repo/open_weather_city_name_repo.dart';
import 'package:weather/domain/repo/weather_data_repo.dart';
import 'package:weather/domain/usecase/cities_local_usecase.dart';
import 'package:weather/domain/usecase/lat_long_to_city_name_usecase.dart';
import 'package:weather/domain/usecase/location_from_city_usecase.dart';
import 'package:weather/domain/usecase/location_usecase.dart';
import 'package:weather/domain/usecase/weather_data_usecase.dart';
import 'package:weather/presentation/controller/geolocation_controller.dart';
import 'package:weather/presentation/controller/location_list_controller.dart';
import 'package:weather/presentation/controller/weather_controller.dart';

import '../../data/repo_impl/location_geolocator_repo.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => (CitiesLocalRepoImpl() as CitiesLocalRepo), fenix: true);
    Get.lazyPut(() => (CitiesLocalUseCase()), fenix: true);
    Get.lazyPut(() => (LocationGeolocatorRepo() as LocationRepo), fenix: true);
    Get.lazyPut(() => (LocationFromCityUsecase()), fenix: true);
    Get.lazyPut(() => (LocationUseCase()), fenix: true);
    Get.lazyPut(() => (WeatherController()), fenix: true);
    Get.lazyPut(() => (LocationListController()), fenix: true);
    Get.lazyPut(() => (GeoCodingRepoImpl() as LatLongToCityNameRepo),
        fenix: true);
    Get.lazyPut(() => (LatLongToCityNameUsecase()), fenix: true);
    Get.lazyPut(() => (GeoLocationController()), fenix: true);
    Get.lazyPut(() => WeatherDataRepoImpl() as WeatherDataRepo, fenix: true);
    Get.lazyPut(() => WeatherDataUsecase(), fenix: true);
    Get.lazyPut(() => OpenWeatherCityNameRepoImpl() as OpenWeatherCityNameRepo,
        fenix: true);
  }
}
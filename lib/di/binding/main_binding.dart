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
import 'package:weather/domain/usecase/hourly_weather_data_usecase.dart';
import 'package:weather/domain/usecase/lat_long_to_city_name_usecase.dart';
import 'package:weather/domain/usecase/location_from_city_usecase.dart';
import 'package:weather/domain/usecase/location_usecase.dart';
import 'package:weather/domain/usecase/weather_data_usecase.dart';

import '../../data/repo_impl/location_geolocator_repo.dart';

class MainBinding {
  CitiesLocalRepo citiesLocalRepo;
  CityNameRepo cityNameRepo;
  CitiesLocalUseCase citiesLocalUseCase;
  LocationRepo locationRepo;
  LocationFromCityUsecase locationFromCityUsecase;
  LocationUseCase locationUseCase;
  WeatherDataRepo weatherDataRepo;
  WeatherDataUsecase weatherDataUsecase;
  HourlyWeatherDataUseCase hourlyWeatherDataUseCase;
  LatLongToCityNameRepo latLongToCityNameRepo;
  LatLongToCityNameUsecase latLongToCityNameUsecase;

  MainBinding(
    this.citiesLocalRepo,
    this.cityNameRepo,
    this.citiesLocalUseCase,
    this.locationRepo,
    this.locationFromCityUsecase,
    this.locationUseCase,
    this.weatherDataRepo,
    this.weatherDataUsecase,
    this.hourlyWeatherDataUseCase,
    this.latLongToCityNameRepo,
    this.latLongToCityNameUsecase,
  );

  factory MainBinding.createBinding() {
    CitiesLocalRepo citiesLocalRepo = CitiesLocalRepoImpl();
    CityNameRepo cityNameRepo = OpenWeatherCityNameRepoImpl();
    CitiesLocalUseCase citiesLocalUseCase = CitiesLocalUseCase(citiesLocalRepo);
    LocationRepo locationRepo = LocationGeolocatorRepo();
    LocationFromCityUsecase locationFromCityUsecase =
        LocationFromCityUsecase(cityNameRepo);
    LocationUseCase locationUseCase = LocationUseCase(locationRepo);
    WeatherDataRepo weatherDataRepo = WeatherDataRepoImpl();
    WeatherDataUsecase weatherDataUsecase = WeatherDataUsecase(weatherDataRepo);
    HourlyWeatherDataUseCase hourlyWeatherDataUseCase =
        HourlyWeatherDataUseCase(weatherDataRepo);
    LatLongToCityNameRepo latLongToCityNameRepo = GeoCodingRepoImpl();
    LatLongToCityNameUsecase latLongToCityNameUsecase =
        LatLongToCityNameUsecase(latLongToCityNameRepo);
    return MainBinding(
      citiesLocalRepo,
      cityNameRepo,
      citiesLocalUseCase,
      locationRepo,
      locationFromCityUsecase,
      locationUseCase,
      weatherDataRepo,
      weatherDataUsecase,
      hourlyWeatherDataUseCase,
      latLongToCityNameRepo,
      latLongToCityNameUsecase,
    );
  }
}
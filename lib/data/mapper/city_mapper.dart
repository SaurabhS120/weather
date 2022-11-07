import 'package:geolocator/geolocator.dart';
import 'package:weather/data/entity/city_data_response.dart';
import 'package:weather/data/entity/city_db_entity.dart';
import 'package:weather/domain/model/city_model.dart';
import 'package:weather/domain/model/location_model.dart';

extension CitiesModelToDBEntityMapper on CityModel {
  CityDBEntity toDbEntity() {
    return CityDBEntity(cityName, locationModel.lattitude.toString(),
        locationModel.longitude.toString());
  }
}

extension CityDbEntityToCityModelMapper on CityDBEntity {
  CityModel toModel() {
    return CityModel(cityName,
        LocationModel(double.parse(lattitude), double.parse(longitude)));
  }

  static toModelList(List<CityDBEntity> cities) {
    return cities.map((e) => e.toModel());
  }
}

extension CitiesModelListToDBEntityMapper on List<CityModel> {
  List<CityDBEntity> toDbEntityList() {
    return map((e) => e.toDbEntity()).toList();
  }
}

extension CitiesEntityListToModelMapper on List<CityDBEntity> {
  List<CityModel> toModelList() {
    return map((e) => e.toModel()).toList();
  }
}

extension CityDataResponseToLocationModel on CityDataResponse {
  LocationModel toModel() {
    return LocationModel(this.lat, this.lon);
  }
}

extension PositionToLocationModelMapper on Position {
  LocationModel toModel() {
    return LocationModel(latitude, longitude);
  }
}

class CityModelMapper {
  CityModel toModel(String cityName, LocationModel locationModel) {
    return CityModel(cityName, locationModel);
  }
}

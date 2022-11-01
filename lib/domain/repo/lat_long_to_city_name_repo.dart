import 'package:weather/domain/entity/location_entity.dart';

abstract class LatLongToCityNameRepo {
  Future<String> getCityName(LocationEntity location);
}

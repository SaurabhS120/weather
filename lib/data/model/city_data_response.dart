import 'package:json_annotation/json_annotation.dart';

part 'city_data_response.g.dart';

@JsonSerializable()
class CityDataResponse {
  double lat;
  double lon;

  CityDataResponse(this.lat, this.lon);

  factory CityDataResponse.fromJson(Map<String, dynamic> json) =>
      _$CityDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CityDataResponseToJson(this);
}

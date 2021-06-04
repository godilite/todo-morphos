import 'package:hive/hive.dart';
part 'location.g.dart';

@HiveType(typeId: 1)
class Location {
  Location({
    required this.name,
    required this.country,
    required this.region,
    required this.lat,
    required this.lon,
    required this.timezoneId,
    required this.localtime,
  });
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String country;
  @HiveField(2)
  final String region;
  @HiveField(3)
  final String lat;
  @HiveField(4)
  final String lon;
  @HiveField(5)
  final String timezoneId;
  @HiveField(6)
  final String localtime;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        name: json["name"],
        country: json["country"],
        region: json["region"],
        lat: json["lat"],
        lon: json["lon"],
        timezoneId: json["timezone_id"],
        localtime: json["localtime"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "country": country,
        "region": region,
        "lat": lat,
        "lon": lon,
        "timezone_id": timezoneId,
        "localtime": localtime,
      };
}

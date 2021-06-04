import 'package:crud_firebase/models/current.dart';
import 'package:crud_firebase/models/location.dart';
import 'package:hive/hive.dart';
part 'weather.g.dart';

@HiveType(typeId: 0)
class Weather {
  @HiveField(0)
  final Location location;

  @HiveField(1)
  final Current current;
  Weather({
    required this.location,
    required this.current,
  });

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        location: Location.fromJson(json["location"]),
        current: Current.fromJson(json["current"]),
      );

  Map<String, dynamic> toMap() => {
        "location": location.toMap(),
        "current": current.toMap(),
      };
}

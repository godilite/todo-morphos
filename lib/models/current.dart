import 'package:hive/hive.dart';
part 'current.g.dart';

@HiveType(typeId: 2)
class Current {
  Current({
    required this.temperature,
    required this.weatherCode,
    required this.windSpeed,
    required this.pressure,
    required this.humidity,
    required this.cloudcover,
    required this.feelslike,
    required this.visibility,
  });
  @HiveField(0)
  final int temperature;
  @HiveField(1)
  final int weatherCode;
  @HiveField(2)
  final int windSpeed;
  @HiveField(3)
  final int pressure;
  @HiveField(4)
  final int humidity;
  @HiveField(5)
  final int cloudcover;
  @HiveField(6)
  final int feelslike;
  @HiveField(7)
  final int visibility;


  factory Current.fromJson(Map<String, dynamic> json) => Current(
        temperature: json["temperature"],
        weatherCode: json["weather_code"],
        windSpeed: json["wind_speed"],
        pressure: json["pressure"],
        humidity: json["humidity"],
        cloudcover: json["cloudcover"],
        feelslike: json["feelslike"],
        visibility: json["visibility"],
      );

  Map<String, dynamic> toMap() => {
        "temperature": temperature,
        "weather_code": weatherCode,
        "wind_speed": windSpeed,
        "pressure": pressure,
        "humidity": humidity,
        "cloudcover": cloudcover,
        "feelslike": feelslike,
        "visibility": visibility,
      };
}

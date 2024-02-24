import 'package:equatable/equatable.dart';

class WeatherEntity extends Equatable {
  final int id;
  final String main;
  final String description;
  final String icon;
  final num temperature;
  final num pressure;
  final num humidity;
  final num wind;
  final DateTime dataTime;
  final String? cityName;

  const WeatherEntity({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
    required this.temperature,
    required this.pressure,
    required this.humidity,
    required this.wind,
    required this.dataTime,
    this.cityName,
  });

  @override
  List<Object?> get props {
    return [
      id,
      main,
      description,
      icon,
      temperature,
      pressure,
      humidity,
      wind,
      dataTime,
      cityName,
    ];
  }
}

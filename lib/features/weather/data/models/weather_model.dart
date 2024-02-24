import 'package:course_weather_forecast/features/weather/domain/entities/weather_entity.dart';

class WeatherModel extends WeatherEntity {
  const WeatherModel({
    required super.id,
    required super.main,
    required super.description,
    required super.icon,
    required super.temperature,
    required super.pressure,
    required super.humidity,
    required super.wind,
    required super.dataTime,
    required super.cityName,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      id: json['weather'][0]['id'],
      main: json['weather'][0]['main'],
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
      temperature: json['main']['temp'],
      pressure: json['main']['pressure'],
      humidity: json['main']['humidity'],
      wind: json['wind']['speed'],
      dataTime: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
      cityName: json['name'],
    );
  }

  Map<String, dynamic> toJson() => {
        "weather": [
          {
            "id": id,
            "main": main,
            "description": description,
            "icon": icon,
          }
        ],
        "main": {
          "temp": temperature,
          "pressure": pressure,
          "humidity": humidity,
        },
        "wind": {
          "speed": wind,
        },
        "dt": dataTime.millisecondsSinceEpoch / 1000,
        "name": cityName,
      };

  WeatherEntity get toEntity => WeatherEntity(
        id: id,
        main: main,
        description: description,
        icon: icon,
        temperature: temperature,
        pressure: pressure,
        humidity: humidity,
        wind: wind,
        dataTime: dataTime,
        cityName: cityName,
      );
}

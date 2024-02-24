import 'package:course_weather_forecast/core/error/failure.dart';
import 'package:course_weather_forecast/features/weather/domain/entities/weather_entity.dart';
import 'package:dartz/dartz.dart';

abstract class WeatherRepository {
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(String cityName);
  Future<Either<Failure, List<WeatherEntity>>> getHourlyForecast(String cityName);
}

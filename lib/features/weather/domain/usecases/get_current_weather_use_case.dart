import 'package:course_weather_forecast/core/error/failure.dart';
import 'package:course_weather_forecast/features/weather/domain/entities/weather_entity.dart';
import 'package:course_weather_forecast/features/weather/domain/repositories/weather_repository.dart';
import 'package:dartz/dartz.dart';

class GetCurrentWeatherUseCase {
  final WeatherRepository _repository;

  GetCurrentWeatherUseCase(this._repository);

  Future<Either<Failure, WeatherEntity>> call(String cityName) {
    return _repository.getCurrentWeather(cityName);
  }
}

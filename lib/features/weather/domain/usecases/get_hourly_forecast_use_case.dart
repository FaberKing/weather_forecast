import 'package:course_weather_forecast/core/error/failure.dart';
import 'package:course_weather_forecast/features/weather/domain/entities/weather_entity.dart';
import 'package:course_weather_forecast/features/weather/domain/repositories/weather_repository.dart';
import 'package:dartz/dartz.dart';

class GetHourlyForecaseUseCase {
  final WeatherRepository _repository;

  GetHourlyForecaseUseCase(this._repository);

  Future<Either<Failure, List<WeatherEntity>>> call(String cityName) {
    return _repository.getHourlyForecast(cityName);
  }
}

import 'package:course_weather_forecast/core/error/failure.dart';
import 'package:course_weather_forecast/features/weather/domain/usecases/get_current_weather_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/dummy_data/weather_data.dart';
import '../../../../helpers/weather_mock.mocks.dart';

void main() {
  late MockWeatherRepository mockWeatherRepository;
  late GetCurrentWeatherUseCase useCase;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    useCase = GetCurrentWeatherUseCase(mockWeatherRepository);
  });

  test(
    'should return [WeatherEntity] when repository success',
    () async {
      // arrange
      when(
        mockWeatherRepository.getCurrentWeather(any),
      ).thenAnswer(
        (_) async => Right(tWeatherEntity),
      );

      // act
      final result = await useCase.call(tCityName);

      // assert
      verify(mockWeatherRepository.getCurrentWeather(tCityName));
      expect(result, Right(tWeatherEntity));
    },
  );

  test(
    'should return [NotFoundFailure] when repository failed',
    () async {
      // arrange
      when(
        mockWeatherRepository.getCurrentWeather(any),
      ).thenAnswer(
        (_) async => const Left(NotFoundFailure('not found')),
      );

      // act
      final result = await useCase(tCityName);

      // assert
      verify(mockWeatherRepository.getCurrentWeather(tCityName));
      expect(result, const Left(NotFoundFailure('not found')));
    },
  );
}

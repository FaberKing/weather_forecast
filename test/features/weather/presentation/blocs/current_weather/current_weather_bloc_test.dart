import 'package:course_weather_forecast/common/app_session.dart';
import 'package:course_weather_forecast/core/error/failure.dart';
import 'package:course_weather_forecast/features/weather/domain/usecases/get_current_weather_use_case.dart';
import 'package:course_weather_forecast/features/weather/presentation/blocs/current_weather/current_weather_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';

import '../../../../../helpers/dummy_data/weather_data.dart';

class MockAppSession extends Mock implements AppSession {}

class MockGetCurrentWeatherUseCase extends Mock implements GetCurrentWeatherUseCase {}

void main() {
  late MockAppSession mockAppSession;
  late MockGetCurrentWeatherUseCase mockGetCurrentWeatherUseCase;
  late CurrentWeatherBloc bloc;

  setUp(() {
    mockAppSession = MockAppSession();
    mockGetCurrentWeatherUseCase = MockGetCurrentWeatherUseCase();
    bloc = CurrentWeatherBloc(mockGetCurrentWeatherUseCase, mockAppSession);
  });

  blocTest<CurrentWeatherBloc, CurrentWeatherState>(
    'emits [CurrentWeatherLoading, CurrentWeatherLoaded]'
    'when usecase is success.',
    build: () {
      when(
        () => mockAppSession.cityName,
      ).thenReturn(tCityName);
      when(
        () => mockGetCurrentWeatherUseCase(any()),
      ).thenAnswer(
        (_) async => Right(tWeatherEntity),
      );

      return bloc;
    },
    act: (bloc) => bloc.add(OnGerCurrentWeatherEvent()),
    expect: () => [
      CurrentWeatherLoading(),
      CurrentWeatherLoaded(tWeatherEntity),
    ],
  );

  blocTest<CurrentWeatherBloc, CurrentWeatherState>(
    'emits [CurrentWeatherLoading, CurrentWeatherFailure]'
    'when usecase is failed.',
    build: () {
      when(
        () => mockAppSession.cityName,
      ).thenReturn(tCityName);
      when(
        () => mockGetCurrentWeatherUseCase(any()),
      ).thenAnswer(
        (_) async => const Left(NotFoundFailure('not found')),
      );

      return bloc;
    },
    act: (bloc) => bloc.add(OnGerCurrentWeatherEvent()),
    expect: () => [
      CurrentWeatherLoading(),
      const CurrentWeatherFailure('not found'),
    ],
  );

  blocTest<CurrentWeatherBloc, CurrentWeatherState>(
    'emits []'
    'when appsession is null.',
    build: () {
      when(
        () => mockAppSession.cityName,
      ).thenReturn(null);
      when(
        () => mockGetCurrentWeatherUseCase(any()),
      ).thenAnswer(
        (_) async => const Left(NotFoundFailure('not found')),
      );

      return bloc;
    },
    act: (bloc) => bloc.add(OnGerCurrentWeatherEvent()),
    expect: () => [],
  );
}

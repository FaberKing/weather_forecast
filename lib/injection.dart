import 'package:course_weather_forecast/common/app_session.dart';
import 'package:course_weather_forecast/features/pick_place/presentation/cubit/city_cubit.dart';
import 'package:course_weather_forecast/features/weather/data/data_source/weather_remote_data_source.dart';
import 'package:course_weather_forecast/features/weather/data/repositories/weather_repository_impl.dart';
import 'package:course_weather_forecast/features/weather/domain/repositories/weather_repository.dart';
import 'package:course_weather_forecast/features/weather/domain/usecases/get_current_weather_use_case.dart';
import 'package:course_weather_forecast/features/weather/domain/usecases/get_hourly_forecast_use_case.dart';
import 'package:course_weather_forecast/features/weather/presentation/blocs/current_weather/current_weather_bloc.dart';
import 'package:course_weather_forecast/features/weather/presentation/blocs/hourly_forecast/hourly_forecast_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final locator = GetIt.instance;

Future<void> initLocator() async {
  // cubit / bloc
  locator.registerFactory(() => CityCubit(locator()));
  locator.registerFactory(() => CurrentWeatherBloc(locator(), locator()));
  locator.registerFactory(() => HourlyForecastBloc(locator(), locator()));

  // usecase
  locator.registerLazySingleton(() => GetCurrentWeatherUseCase(locator()));
  locator.registerLazySingleton(() => GetHourlyForecaseUseCase(locator()));

  // datasource
  locator.registerLazySingleton<WeatherRemoteDataSource>(
    () => WeatherRemoteDataSourceImpl(locator()),
  );

  // repository
  locator.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(locator()),
  );

  //common
  locator.registerLazySingleton(() => AppSession(locator()));

  // external
  final pref = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => pref);
  locator.registerLazySingleton(() => http.Client());
}

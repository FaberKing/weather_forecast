import 'package:course_weather_forecast/common/app_session.dart';
import 'package:course_weather_forecast/features/weather/domain/entities/weather_entity.dart';
import 'package:course_weather_forecast/features/weather/domain/usecases/get_current_weather_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'current_weather_event.dart';
part 'current_weather_state.dart';

class CurrentWeatherBloc extends Bloc<CurrentWeatherEvent, CurrentWeatherState> {
  final GetCurrentWeatherUseCase _useCase;
  final AppSession _appSession;
  CurrentWeatherBloc(this._useCase, this._appSession) : super(CurrentWeatherInitial()) {
    on<OnGerCurrentWeatherEvent>((event, emit) async {
      String? cityName = _appSession.cityName;
      if (cityName == null) return;

      emit(CurrentWeatherLoading());

      final result = await _useCase(cityName);
      result.fold(
        (failure) => emit(CurrentWeatherFailure(failure.message)),
        (data) => emit(CurrentWeatherLoaded(data)),
      );
    });
  }
}

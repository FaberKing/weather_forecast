import 'package:course_weather_forecast/common/app_session.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CityCubit extends Cubit<String> {
  final AppSession appSession;
  CityCubit(this.appSession) : super('');

  String init() {
    String? city = appSession.cityName;
    if (city != null) emit(city);
    return state;
  }

  listChange(String n) {
    emit(n);
  }

  saveCity() {
    appSession.saveCityName(state);
  }
}

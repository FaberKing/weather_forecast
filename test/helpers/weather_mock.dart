import 'package:course_weather_forecast/features/weather/domain/repositories/weather_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateNiceMocks([
  MockSpec<WeatherRepository>(as: #MockWeatherRepository),
  MockSpec<http.Client>(as: #MockHttpClient),
])
void main() {}

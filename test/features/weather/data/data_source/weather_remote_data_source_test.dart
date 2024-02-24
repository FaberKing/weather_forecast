import 'package:course_weather_forecast/api/key.dart';
import 'package:course_weather_forecast/api/urls.dart';
import 'package:course_weather_forecast/core/error/exception.dart';
import 'package:course_weather_forecast/features/weather/data/data_source/weather_remote_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../../../helpers/dummy_data/weather_data.dart';
import '../../../../helpers/json_reader.dart';
import '../../../../helpers/weather_mock.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late WeatherRemoteDataSourceImpl weatherRemoteDataSourceImpl;

  setUp(() {
    mockHttpClient = MockHttpClient();
    weatherRemoteDataSourceImpl = WeatherRemoteDataSourceImpl(mockHttpClient);
  });

  test(
    'should return [WeatherModel] when status code is 200',
    () async {
      // arrange
      when(mockHttpClient.get(any)).thenAnswer(
        (_) async => http.Response(readJson('current_weather.json'), 200),
      );
      // act
      final result = await weatherRemoteDataSourceImpl.getCurrentWeather(tCityName);
      // assert
      String countryCode = "ID";
      Uri url = Uri.parse('${URLs.base}/weather?q=$tCityName,$countryCode&appid=$apiKey');
      verify(mockHttpClient.get(url));
      expect(result, tWeatherModel);
    },
  );

  test(
    'should throw [NotFoundException] when status code is 404',
    () async {
      // arrange
      when(mockHttpClient.get(any)).thenAnswer(
        (_) async => http.Response('not found', 404),
      );
      // act
      final result = weatherRemoteDataSourceImpl.getCurrentWeather(tCityName);
      // assert
      String countryCode = "ID";
      Uri url = Uri.parse('${URLs.base}/weather?q=$tCityName,$countryCode&appid=$apiKey');
      verify(mockHttpClient.get(url));
      expect(result, throwsA(isA<NotFoundException>()));
    },
  );

  test(
    'should throw [ServerException] when status code is not 200 and 404',
    () async {
      // arrange
      when(mockHttpClient.get(any)).thenAnswer(
        (_) async => http.Response('server error', 500),
      );
      // act
      final result = weatherRemoteDataSourceImpl.getCurrentWeather(tCityName);
      // assert
      String countryCode = "ID";
      Uri url = Uri.parse('${URLs.base}/weather?q=$tCityName,$countryCode&appid=$apiKey');
      verify(mockHttpClient.get(url));
      expect(result, throwsA(isA<ServerException>()));
    },
  );
}

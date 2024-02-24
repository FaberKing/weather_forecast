import 'dart:convert';

import 'package:course_weather_forecast/api/key.dart';
import 'package:course_weather_forecast/api/urls.dart';
import 'package:course_weather_forecast/core/error/exception.dart';
import 'package:course_weather_forecast/features/weather/data/models/weather_model.dart';
import 'package:http/http.dart' as http;

abstract class WeatherRemoteDataSource {
  Future<WeatherModel> getCurrentWeather(String cityName);
  Future<List<WeatherModel>> getHourlyForecase(String cityName);
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final http.Client _client;

  WeatherRemoteDataSourceImpl(this._client);
  @override
  Future<WeatherModel> getCurrentWeather(String cityName) async {
    String countryCode = "ID";
    Uri url = Uri.parse('${URLs.base}/weather?q=$cityName,$countryCode&appid=$apiKey');
    final response = await _client.get(url);
    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      return WeatherModel.fromJson(responseBody);
    } else if (response.statusCode == 404) {
      throw NotFoundException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<WeatherModel>> getHourlyForecase(String cityName) async {
    String countryCode = "ID";
    Uri url = Uri.parse('${URLs.base}/forecast?q=$cityName,$countryCode&appid=$apiKey');
    final response = await _client.get(url);
    if (response.statusCode == 200) {
      Map responseBody = jsonDecode(response.body);
      List list = responseBody['list'];
      return list.map((e) => WeatherModel.fromJson(Map.from(e))).toList();
    } else if (response.statusCode == 404) {
      throw NotFoundException();
    } else {
      throw ServerException();
    }
  }
}

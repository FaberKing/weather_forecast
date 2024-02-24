import 'dart:convert';

import 'package:course_weather_forecast/features/weather/data/models/weather_model.dart';
import 'package:course_weather_forecast/features/weather/domain/entities/weather_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/dummy_data/weather_data.dart';
import '../../../../helpers/json_reader.dart';

void main() {
  test(
    'should a sub class [WeatherEntity]',
    () async {
      // arrange

      // act

      // assert
      expect(tWeatherModel, isA<WeatherEntity>());
    },
  );

  test(
    'should return valid model from json',
    () async {
      // arrange
      String jsonString = readJson('current_weather.json');
      Map<String, dynamic> jsonMap = jsonDecode(jsonString);

      // act
      final result = WeatherModel.fromJson(jsonMap);

      // assert
      // expect(result, isA<WeatherModel>());
      expect(result, tWeatherModel);
    },
  );

  test(
    'should return a valid json map',
    () async {
      // arrange
      // act
      final result = tWeatherModel.toJson();

      // assert
      expect(result, tWeatherJsonMap);
    },
  );

  test(
    'should return a valid [WeatherEntity]',
    () async {
      // arrange
      // act
      final result = tWeatherModel.toEntity;

      // assert
      expect(result, tWeatherEntity);
    },
  );
}

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_clean_architecture_bloc/data/models/weather_model.dart';
import 'package:tdd_clean_architecture_bloc/domain/entities/weather.dart';

import '../../helpers/json_reader.dart';

void main() {
  const tWeatherModel = WeatherModel(
    cityName: "New York",
    main: "Clear",
    description: "clear sky",
    iconCode: '01n',
    temperature: 298.53,
    pressure: 1012,
    humidity: 73,
  );
  test(
    "should be a subclass of Weather Entity",
    () async {
      // assert
      expect(tWeatherModel, isA<WeatherEntity>());
    },
  );

  test(
    "should return a valid model from json",
    () async {
      // arrange
      final Map<String, dynamic> json = jsonDecode(
        readJson('helpers/dummy_data/dummy_weather.json'),
      );

      // act
      final result = WeatherModel.fromJson(json);

      // assert
      expect(result, equals(tWeatherModel));
    },
  );

  test(
    "should return a json map containing proper data",
    () async {
      // act
      final result = tWeatherModel.toJson();

      // assert
      final expectedJsonMap = {
        'weather': [
          {
            'main': 'Clear',
            'description': 'clear sky',
            'icon': '01n',
          }
        ],
        'main': {
          'temp': 298.53,
          'pressure': 1012,
          'humidity': 73,
        },
        'name': 'New York',
      };
      expect(result, expectedJsonMap);
    },
  );
}

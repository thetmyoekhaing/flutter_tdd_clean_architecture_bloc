import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tdd_clean_architecture_bloc/core/constants/constants.dart';
import 'package:tdd_clean_architecture_bloc/core/error/exception.dart';
import 'package:tdd_clean_architecture_bloc/data/models/weather_model.dart';

abstract class WeatherRemoteDataSource {
  Future<WeatherModel> getCurrentWeather(String cityName);
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final http.Client _httpClient;

  WeatherRemoteDataSourceImpl(this._httpClient);

  @override
  Future<WeatherModel> getCurrentWeather(String cityName) async {
    final res = await _httpClient.get(
      Uri.parse(Urls.currentWeatherByName(cityName)),
    );

    if (res.statusCode == 200) {
      return WeatherModel.fromJson(jsonDecode(res.body));
    } else {
      throw ServerException();
    }
  }
}

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_clean_architecture_bloc/core/constants/constants.dart';
import 'package:tdd_clean_architecture_bloc/core/error/exception.dart';
import 'package:tdd_clean_architecture_bloc/data/data_sources/remote_data_source.dart';
import 'package:tdd_clean_architecture_bloc/domain/entities/weather.dart';

import '../../helpers/json_reader.dart';
import '../../helpers/test_helpers.mocks.dart';
import 'package:http/http.dart' as http;

void main() {
  late MockHttpClient mockHttpClient;
  late WeatherRemoteDataSourceImpl weatherRemoteDataSourceImpl;

  setUp(() {
    mockHttpClient = MockHttpClient();
    weatherRemoteDataSourceImpl = WeatherRemoteDataSourceImpl(mockHttpClient);
  });

  group("get current data", () {
    const tCityName = "New York";

    test(
      "should return weather model when the api call is successful (200)",
      () async {
        // arrange

        when(
          mockHttpClient.get(Uri.parse(
            Urls.currentWeatherByName(tCityName),
          )),
        ).thenAnswer(
          (_) async => http.Response(
              readJson("/helpers/dummy_data/dummy_weather.json"), 200),
        );

        // act
        final result =
            await weatherRemoteDataSourceImpl.getCurrentWeather(tCityName);

        // assert
        expect(result, isA<WeatherEntity>());
      },
    );

    test(
      "should throw a server exception when the api call is unsuccessful (404 or others)",
      () async {
        // arrange

        when(
          mockHttpClient.get(Uri.parse(
            Urls.currentWeatherByName(tCityName),
          )),
        ).thenAnswer(
          (_) async => http.Response("Not Found", 404),
        );

        // act
        final result = weatherRemoteDataSourceImpl.getCurrentWeather(tCityName);

        // assert
        expect(result, throwsA(isA<ServerException>()));
      },
    );
  });
}

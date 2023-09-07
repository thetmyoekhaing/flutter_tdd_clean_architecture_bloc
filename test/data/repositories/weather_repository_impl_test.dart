import 'dart:io';
import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_clean_architecture_bloc/core/error/exception.dart';
import 'package:tdd_clean_architecture_bloc/core/error/failure.dart';
import 'package:tdd_clean_architecture_bloc/data/models/weather_model.dart';
import 'package:tdd_clean_architecture_bloc/data/repositories/weather_repository_impl.dart';
import 'package:tdd_clean_architecture_bloc/domain/entities/weather.dart';

import '../../helpers/test_helpers.mocks.dart';

void main() {
  late MockWeatherRemoteDataSource mockWeatherRemoteDataSource;
  late WeatherRepositoryImpl weatherRepository;

  setUp(() {
    mockWeatherRemoteDataSource = MockWeatherRemoteDataSource();
    weatherRepository = WeatherRepositoryImpl(mockWeatherRemoteDataSource);
  });

  const tCity = "New York";

  const tWeatherEntity = WeatherEntity(
    cityName: tCity,
    main: "Clouds",
    description: "few clouds",
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  const tWeatherModel = WeatherModel(
    cityName: tCity,
    main: "Clouds",
    description: "few clouds",
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  group("get current data", () {
    test(
      "should return the current weather when a call to dataSource is successful",
      () async {
        // arrange
        when(mockWeatherRemoteDataSource.getCurrentWeather(tCity))
            .thenAnswer((_) async => tWeatherModel);
        // act

        final result = await weatherRepository.getCurrentWeather(tCity);

        // assert

        expect(result, equals(const Right(tWeatherEntity)));
      },
    );

    test(
      "should return server failure when a call to dataSource is unsuccessful",
      () async {
        // arrange
        when(mockWeatherRemoteDataSource.getCurrentWeather(tCity))
            .thenThrow(ServerException());
        // act

        final result = await weatherRepository.getCurrentWeather(tCity);

        // assert

        expect(
            result,
            equals(const Left(ServerFailure(
                "An error occured while getting the current weather"))));
      },
    );

    test(
      "should return connection failure when the device has no internet connection",
      () async {
        // arrange
        when(mockWeatherRemoteDataSource.getCurrentWeather(tCity)).thenThrow(
            const SocketException("Failed to connect to the network"));
        // act

        final result = await weatherRepository.getCurrentWeather(tCity);

        // assert

        expect(
            result,
            equals(const Left(
                ConnectionFailure("Failed to connect to the network"))));
      },
    );
  });
}

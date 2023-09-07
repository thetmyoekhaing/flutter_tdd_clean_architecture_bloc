import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_clean_architecture_bloc/core/error/failure.dart';
import 'package:tdd_clean_architecture_bloc/domain/entities/weather.dart';
import 'package:tdd_clean_architecture_bloc/presentation/bloc/weather_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import '../../helpers/test_helpers.mocks.dart';

void main() {
  late MockGetCurrentWeatherUseCase mockGetCurrentWeatherUseCase;
  late WeatherBloc weatherBloc;

  setUp(() {
    mockGetCurrentWeatherUseCase = MockGetCurrentWeatherUseCase();
    weatherBloc = WeatherBloc(mockGetCurrentWeatherUseCase);
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

  test(
    "initial state should be WeatherInitial",
    () {
      expect(weatherBloc.state, WeatherInitial());
    },
  );

  blocTest<WeatherBloc, WeatherState>(
    'should emits [WeatherLoading,WeatherLoaded] when data is gotten successfully',

    // arrange
    build: () {
      when(mockGetCurrentWeatherUseCase.getCurrentWeather(tCity))
          .thenAnswer((_) async => const Right(tWeatherEntity));
      return weatherBloc;
    },
    act: (bloc) => bloc.add(const OnCityChanged(tCity)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      WeatherLoading(),
      const WeatherLoaded(tWeatherEntity),
    ],
  );

  blocTest<WeatherBloc, WeatherState>(
    'should emits [WeatherLoading,WeatherLoadedFailed] when data is gotten unsuccessfully',

    // arrange
    build: () {
      when(mockGetCurrentWeatherUseCase.getCurrentWeather(tCity))
          .thenAnswer((_) async => const Left(ServerFailure("Server failure")));
      return weatherBloc;
    },
    act: (bloc) => bloc.add(const OnCityChanged(tCity)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      WeatherLoading(),
      const WeatherLoadedFailed("Server failure"),
    ],
  );
}

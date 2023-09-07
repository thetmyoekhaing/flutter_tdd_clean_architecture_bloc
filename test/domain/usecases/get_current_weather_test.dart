import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_clean_architecture_bloc/domain/entities/weather.dart';
import 'package:tdd_clean_architecture_bloc/domain/usecases/get_current_weather.dart';

import '../../helpers/test_helpers.mocks.dart';

void main() {
  late GetCurrentWeatherUseCase getCurrentWeatherUseCase;
  late MockWeatherRepository mockWeatherRepository;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    getCurrentWeatherUseCase = GetCurrentWeatherUseCase(mockWeatherRepository);
  });

  const testCityName = "New York";

  const tWeatherDetail = WeatherEntity(
    cityName: testCityName,
    main: "Clouds",
    description: "few clouds",
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  test(
    "should return current weather detail from the repository",
    () async {
      // arrange
      when(mockWeatherRepository.getCurrentWeather(testCityName)).thenAnswer(
        (_) async => const Right(tWeatherDetail),
      );

      // act
      final result =
          await getCurrentWeatherUseCase.getCurrentWeather(testCityName);

      // assert
      expect(result, const Right(tWeatherDetail));
    },
  );
}

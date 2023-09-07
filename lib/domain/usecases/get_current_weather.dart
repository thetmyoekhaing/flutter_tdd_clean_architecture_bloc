import 'package:dartz/dartz.dart';
import 'package:tdd_clean_architecture_bloc/core/error/failure.dart';
import 'package:tdd_clean_architecture_bloc/domain/entities/weather.dart';
import 'package:tdd_clean_architecture_bloc/domain/repositories/weather_repository.dart';

class GetCurrentWeatherUseCase {
  final WeatherRepository _weatherRepository;

  const GetCurrentWeatherUseCase(this._weatherRepository);

  Future<Either<Failure, WeatherEntity>> getCurrentWeather(String cityName) {
    return _weatherRepository.getCurrentWeather(cityName);
  }
}

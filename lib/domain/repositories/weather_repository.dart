import 'package:dartz/dartz.dart';
import 'package:tdd_clean_architecture_bloc/core/error/failure.dart';
import 'package:tdd_clean_architecture_bloc/domain/entities/weather.dart';

abstract class WeatherRepository {
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(String cityName);
}

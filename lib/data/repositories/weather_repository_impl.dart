import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:tdd_clean_architecture_bloc/core/error/exception.dart';
import 'package:tdd_clean_architecture_bloc/core/error/failure.dart';
import 'package:tdd_clean_architecture_bloc/data/data_sources/remote_data_source.dart';
import 'package:tdd_clean_architecture_bloc/domain/entities/weather.dart';
import 'package:tdd_clean_architecture_bloc/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl extends WeatherRepository {
  final WeatherRemoteDataSource _dataSource;

  WeatherRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(
      String cityName) async {
    try {
      final result = await _dataSource.getCurrentWeather(cityName);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(
          ServerFailure("An error occured while getting the current weather"));
    } on SocketException {
      return const Left(ConnectionFailure("Failed to connect to the network"));
    }
  }
}

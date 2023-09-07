import 'package:get_it/get_it.dart';
import 'package:tdd_clean_architecture_bloc/data/data_sources/remote_data_source.dart';
import 'package:tdd_clean_architecture_bloc/data/repositories/weather_repository_impl.dart';
import 'package:tdd_clean_architecture_bloc/domain/repositories/weather_repository.dart';
import 'package:tdd_clean_architecture_bloc/domain/usecases/get_current_weather.dart';
import 'package:tdd_clean_architecture_bloc/presentation/bloc/weather_bloc.dart';
import 'package:http/http.dart' as http;

final locator = GetIt.I;

void setupLocator() {
  // bloc
  locator.registerFactory(() => WeatherBloc(locator()));

  // usecase
  locator.registerLazySingleton(() => GetCurrentWeatherUseCase(locator()));

  // repository
  locator.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(locator()),
  );

  // data source
  locator.registerLazySingleton<WeatherRemoteDataSource>(
    () => WeatherRemoteDataSourceImpl(locator()),
  );

  // external
  locator.registerLazySingleton(() => http.Client());
}

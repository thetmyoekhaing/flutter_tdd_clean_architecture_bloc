import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tdd_clean_architecture_bloc/domain/entities/weather.dart';
import 'package:tdd_clean_architecture_bloc/domain/usecases/get_current_weather.dart';
import 'package:rxdart/rxdart.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetCurrentWeatherUseCase _getCurrentWeatherUseCase;

  WeatherBloc(this._getCurrentWeatherUseCase) : super(WeatherInitial()) {
    on<OnCityChanged>(
      (event, emit) async {
        emit(WeatherLoading());
        if (event.cityName.isNotEmpty) {
          final result =
              await _getCurrentWeatherUseCase.getCurrentWeather(event.cityName);
          result.fold(
            (failure) => emit(
              WeatherLoadedFailed(failure.message),
            ),
            (data) => emit(
              WeatherLoaded(data),
            ),
          );
        } else {
          debugPrint("--------------------- empty ------------------");
          emit(WeatherInitial());
        }
      },
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}

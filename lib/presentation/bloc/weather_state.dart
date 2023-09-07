part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

final class WeatherInitial extends WeatherState {}

final class WeatherLoading extends WeatherState {}

final class WeatherLoaded extends WeatherState {
  final WeatherEntity data;

  const WeatherLoaded(this.data);
}

final class WeatherLoadedFailed extends WeatherState {
  final String error;

  const WeatherLoadedFailed(this.error);
}

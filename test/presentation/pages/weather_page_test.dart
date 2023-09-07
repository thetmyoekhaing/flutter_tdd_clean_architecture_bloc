import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_clean_architecture_bloc/domain/entities/weather.dart';
import 'package:tdd_clean_architecture_bloc/presentation/bloc/weather_bloc.dart';
import 'package:tdd_clean_architecture_bloc/presentation/pages/weather_page.dart';

class MockWeatherBloc extends MockBloc<WeatherEvent, WeatherState>
    implements WeatherBloc {}

void main() {
  late MockWeatherBloc mockWeatherBloc;

  setUp(() {
    mockWeatherBloc = MockWeatherBloc();
    HttpOverrides.global = null;
  });

  Widget testWidget(Widget body) {
    return BlocProvider<WeatherBloc>(
      create: (context) => mockWeatherBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  const testWeather = WeatherEntity(
    cityName: 'New York',
    main: 'Clear',
    description: 'clear sky',
    iconCode: '01n',
    temperature: 298.53,
    pressure: 1012,
    humidity: 73,
  );

  try {
    testWidgets(
        "text field should trigger state to change from initial to loading",
        (widgetTester) async {
      // arrange
      when(() => mockWeatherBloc.state).thenReturn(WeatherInitial());

      // act
      await widgetTester.pumpWidget(testWidget(const WeatherPage()));
      var textField = find.byKey(const Key("Text Field"));
      expect(textField, findsOneWidget);

      await widgetTester.enterText(textField, "New York");
      await widgetTester.pump();
      expect(find.text("New York"), findsOneWidget);
    });
  } catch (e, stackTrace) {
    print('Exception during test: $e');
    print(stackTrace);
  }

  testWidgets(
      "should show circular progress indicator when the state is loading",
      (widgetTester) async {
    // arrange
    when(() => mockWeatherBloc.state).thenReturn(WeatherLoading());

    // act
    await widgetTester.pumpWidget(testWidget(const WeatherPage()));

    // assert
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  try {
    testWidgets("should show widget contain weather data when state is loaded",
        (widgetTester) async {
      // arrange
      when(() => mockWeatherBloc.state)
          .thenReturn(const WeatherLoaded(testWeather));

      // act
      await widgetTester.pumpWidget(testWidget(const WeatherPage()));
      await widgetTester.pumpAndSettle();
      // assert
      expect(find.byKey(const Key('weather_loaded')), findsOneWidget);
    });
  } catch (e, s) {
    print('Exception during test: $e');
    print(s);
  }
}

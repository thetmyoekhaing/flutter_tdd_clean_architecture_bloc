import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdd_clean_architecture_bloc/injection.dart';
import 'package:tdd_clean_architecture_bloc/presentation/bloc/weather_bloc.dart';
import 'package:tdd_clean_architecture_bloc/presentation/pages/weather_page.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter TDD Clean Architecture with BLoC",
      home: BlocProvider<WeatherBloc>(
        create: (context) => locator.call(),
        child: const WeatherPage(),
      ),
    );
  }
}

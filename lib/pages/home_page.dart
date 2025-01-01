import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/models/weather_model.dart';
import 'package:weatherapp/pages/search_page.dart';
import 'package:weatherapp/weather_cubit/weather_cubit.dart';
import 'package:weatherapp/weather_cubit/weather_state.dart';
import 'package:weatherapp/widget/no_weather_data.dart';
import 'package:weatherapp/widget/weather_success.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  WeatherModel? weatherData;

  @override
  Widget build(BuildContext context) {
    final weatherCubit = BlocProvider.of<WeatherCubit>(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SearchPage();
              }));
            },
            icon: Icon(Icons.search),
          ),
        ],
        title: Text('Weather App'),
      ),
      body: BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, state) {
          if (state is WeatherLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is WeatherSuccessState) {
            weatherData =  weatherCubit.weatherModel;
            return WeatherSuccess(weatherData: weatherData);
          } else if (state is WeatherFailureState) {
            return const Center(
              child: Text('something wrong'),
            );
          } else {
            return const NoWeatherData();
          }
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/models/weather_model.dart';
import 'package:weatherapp/services/weather_service.dart';
import 'package:weatherapp/weather_cubit/weather_cubit.dart';

// ignore: must_be_immutable
class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);
  String? cityName;
  @override
  Widget build(BuildContext context) {
    final weatherCubit = BlocProvider.of<WeatherCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Search a City'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            onChanged: (data) {
              cityName = data;
            },
            onSubmitted: (data) async {
              cityName = data;
              weatherCubit.cityName;
              Navigator.pop(context);
            },
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 32, horizontal: 24),
              label: Text('search'),
              suffixIcon: GestureDetector(
                  onTap: () async {
                    WeatherService service = WeatherService();

                    WeatherModel? weather =
                        await service.getWeather(cityName: cityName!);

                    Navigator.pop(context);
                  },
                  child: Icon(Icons.search)),
              border: OutlineInputBorder(),
              hintText: 'Enter a city',
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/models/weather_model.dart';
import 'package:weatherapp/weather_cubit/weather_cubit.dart';

class WeatherSuccess extends StatelessWidget {
  const WeatherSuccess({Key? key, required this.weatherData}) : super(key: key);
  final WeatherModel? weatherData;

  @override
  Widget build(BuildContext context) {
    // Use default values if weatherData is null
    final String cityName =
        BlocProvider.of<WeatherCubit>(context).cityName ?? 'Unknown City';
    final double temp = weatherData?.temp ?? 0.0;
    final double maxTemp = weatherData?.maxTemp ?? 0.0;
    final double minTemp = weatherData?.minTemp ?? 0.0;
    final String weatherStateName =
        weatherData?.weatherStateName ?? 'Clear Sky';

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            weatherData?.getThemeColor() ?? Colors.blue, // Default blue color
            (weatherData?.getThemeColor() ?? Colors.blue).withOpacity(0.6),
            (weatherData?.getThemeColor() ?? Colors.blue).withOpacity(0.3),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(flex: 3),
          Text(
            cityName,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Updated at: ${weatherData?.date.hour ?? '00'}:${weatherData?.date.minute ?? '00'}',
            style: const TextStyle(
              fontSize: 22,
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                weatherData?.getImage() ?? 'assets/images/default.png',
                height: 100,
              ),
              Text(
                '${temp.toInt()}°C',
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Column(
                children: [
                  Text('Max: ${maxTemp.toInt()}°C'),
                  Text('Min: ${minTemp.toInt()}°C'),
                ],
              ),
            ],
          ),
          const Spacer(),
          Text(
            weatherStateName,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(flex: 5),
        ],
      ),
    );
  }
}
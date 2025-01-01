import 'package:bloc/bloc.dart';
import 'package:weatherapp/models/weather_model.dart';
import 'package:weatherapp/services/weather_service.dart';
import 'package:weatherapp/weather_cubit/weather_state.dart';


class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit(this.weatherServices) : super(WeatherInitialState());
  WeatherService weatherServices;
  String? cityName;
  WeatherModel? weatherModel;
  void getWeather({required String cityName}) async {
    emit(WeatherLoadingState());
    try {
      weatherModel = await weatherServices.getWeather(cityName: cityName);
      emit(WeatherSuccessState());
    } on Exception {
      emit(WeatherFailureState());
    }
  }
}

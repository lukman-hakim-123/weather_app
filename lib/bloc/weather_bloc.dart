import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/data/repository/weather_repository.dart';
import 'package:weather_app/models/weather_model.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;
  WeatherBloc(this.weatherRepository) : super(WeatherInitial()) {
    on<WeatherFetchEvent>(_getCurrentWeather);
  }

  void _getCurrentWeather(
      WeatherFetchEvent event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());
    try {
      final weather = await weatherRepository.getCurrentWeather();
      emit(WeatherSuccess(weatherModel: weather));
    } catch (e) {
      emit(WeatherFailure(e.toString()));
    }
  }
}

import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
const APIkey= 'b15f406871bf4a032805603d4aa7a497';

class WeatherModel {

  Future<dynamic> getCityWeather(String cityName) async
  {
    var url='https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$APIkey&units=metric';
    NetworkHelper networkHelper = NetworkHelper(url);

    var weatherData= await networkHelper.getData();
    return weatherData;
  }


  Future<dynamic> getLocationWeather() async
  {
    Location location = Location();
    await location.getCurrentLocation();
    NetworkHelper networkHelper = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$APIkey&units=metric');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }
  String getWeatherStatus(int condition) {
    if (condition < 300) {
      return 'thunderstorm';
    } else if (condition < 600) {
      return 'rainy';
    } else if (condition < 700) {
      return 'snow';
    } else if (condition == 800) {
      return 'clear';
    } else if (condition <= 804) {
      return 'cloudy';
    }
    else
      return 'error';
  }
  String dayORnight(int time)
  {
    if(time>=18 && time<=6)
      print("Night");
    else if(time>6 && time<18)
      print("Day");
  }
}

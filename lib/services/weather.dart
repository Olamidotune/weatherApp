import 'dart:core';
import 'package:flutter/material.dart';
import 'package:getweather/services/location.dart';
import 'package:getweather/services/networking.dart';

const apiKey = '6242316f386a8a1d8f1580e186747cbb';

class WeatherModel {
  Future <dynamic> getCityWeather(String cityName) async {
    Location location = Location();
    await location.getCurrentLocation();
    var url ='https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric';
    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = await networkHelper.getNetworkData();

    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    // remember for await to work, you need to use fututre in it method.
    await location.getCurrentLocation();
    await location.determinePosition();

    NetworkHelper networkHelper = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getNetworkData();

    return weatherData;
  }

  getWeatherIcon(int condition) {
    if (condition < 200) {
      return Image.asset('assets/png/thunderstorm-icon-15885.png');
    } else if (condition < 300) {
      return Image.asset('assets/png/pngaaa.com-213086.png');
    } else if (condition < 500) {
      return Image.asset('assets/png/icons8-rain-64.png');
    } else if (condition < 600) {
      return Image.asset('assets/png/pngaaa.com-213086.png');
    } else if (condition < 700) {
      return Image.asset('assets/png/icons8-sun-240.png');
    } else if (condition == 800) {
      return Image.asset('assets/png/icons8-sun-240.png');
    } else if (condition >= 800) {
      return Image.asset('assets/png/pngaaa.com-1562988.png');
    } else {
      return 'number';
    }
  }

  String backgroundImage(int temp) {
    if (temp > 25) {
      return 'it';
    } else if (temp > 20) {
      return 'the temperature is low';
    } else if (temp < 10) {
      return "It's so cold outside my brother";
    } else {
      return 'bring me';
    }
  }
}

import 'dart:core';
import 'package:flutter/material.dart';
import 'package:getweather/services/location.dart';
import 'package:getweather/services/networking.dart';

const apiKey = '6242316f386a8a1d8f1580e186747cbb';

class WeatherModel {
  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    // remember for await to work, you need to use fututre in it method.
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getNetworkData();

    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️ ';
    } else if (condition < 800) {
      return '🌫️';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 800) {
      return '☁️';
    } else {
      return 'omo na you sabii ooo 😹😹😹';
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

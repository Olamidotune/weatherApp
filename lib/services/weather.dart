import 'dart:core';

import 'package:flutter/material.dart';

class WeatherModel {
  String(int condition) {
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
}

 String backgroundImage (int temp){
  if  (temp>25){
    return 'it';
  }else if (temp >20){
    return '20';
  }else if (temp <10){
    return '10';
  }else {
    return 'bring me';
  }
 }

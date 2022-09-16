import 'package:flutter/material.dart';
import 'package:getweather/screens/home_screen.dart';
import 'package:getweather/screens/location_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName:(context) => const HomeScreen(),
        LocationScreen.routeName:(context) =>  const LocationScreen(),
      },
    );
  }
}

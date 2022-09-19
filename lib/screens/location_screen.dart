import 'package:flutter/material.dart';
import 'package:getweather/screens/city_screen.dart';
import 'package:getweather/services/weather.dart';

class LocationScreen extends StatefulWidget {
  static const String routeName = 'LoadingScreen';
  final locationWeather;

  const LocationScreen({Key? key, this.locationWeather}) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  late int temperature;
  late String weatherIcon;
  late String cityName;
  late String getBackgroundImage;

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        cityName = '';
        weatherIcon = '';
        getBackgroundImage = '';
        showDialog(
          context: context,
          builder: (BuildContext context) => const ErrorDialog(),
        );
        return;
      }
      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      getBackgroundImage = weather.backgroundImage(temp.toInt());
      //condition is a var only in updateUI
      var condition = weatherData['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition);
      cityName = weatherData['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () async {
            var weatherData = await weather.getLocationWeather();
            updateUI(weatherData);
          },
          icon: const Icon(
            Icons.pin_drop_outlined,
            size: 40,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const CityScreen();
                },
              ),
            ),
            icon: const Icon(
              Icons.location_city_outlined,
              size: 30,
            ),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: const AssetImage('assets/images/loadingScreen.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.8), BlendMode.dstIn)),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                'Your are in $cityName',
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                " $getBackgroundImage in $cityName ",
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                weatherIcon,
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                '$temperatureº',
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      title: Align(
        alignment: Alignment.topRight,
        child: GestureDetector(
          child: Icon(Icons.close),
          onTap: () => Navigator.pop(context),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.error),
          SizedBox(
            height: 10,
          ),
          Text(
            'STAY SAFE',
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w400,
                fontFamily: 'Mulish',
                color: Colors.black),
          ),
          SizedBox(
            height: 29,
          ),
          Text(
            'Let\'s remember to put on our face mask and follow COVID-19 guidelines while handing over or interacting with your delivery driver.',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontFamily: 'Mulish',
                color: Colors.black),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 43,
          ),
        ],
      ),
    );
  }
}

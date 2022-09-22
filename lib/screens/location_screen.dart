import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
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
  late Image weatherIcon;
  late String cityName;
  late String description;
  late String getBackgroundImage;
  late String countryName;
  late double windSpeed;
  late int humidity;
  late double coordinateLon;
  late double coordinateLat;
  late int temperatureMin;
  late int temperatureMax;
  double? latitude;
  double? longitude;

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
    getCurrentLocation;
    WidgetsBinding.instance.addPostFrameCallback;
  }

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.medium);
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      ('unable to read ');
    }
  }


  void updateUI(dynamic weatherData) {

    setState(() {
      if (weatherData == null) {
        temperature = 0;
        cityName = '';
        weatherIcon = Image.network('https://bit.ly/3xzgaa4');
        getBackgroundImage = '';
        description = '';
        countryName = '';
        windSpeed = 0.0;
        humidity = 0;
        coordinateLon = 0.0;
        coordinateLat = 0.0;
        temperatureMin = 0;
        temperatureMax = 0;

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
      description = weatherData['weather'][0]['description'];
      countryName = weatherData['sys']['country'];
      double speed = weatherData['wind']['speed'];
      windSpeed = speed.toDouble();
      humidity = weatherData['main']['humidity'];
      double coord = weatherData['coord']['lon'];
      coordinateLon = coord.toDouble();
      double coordd = weatherData['coord']['lat'];
      coordinateLat = coordd.toDouble();
      double tempMin = weatherData['main']['temp_min'];
      temperatureMin = tempMin.toInt();
      double tempMax = weatherData['main']['temp_max'];
      temperatureMax = tempMax.toInt();
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
            getCurrentLocation;
            var weatherData = await weather.getLocationWeather();
            updateUI(weatherData);
          },
          icon: const Icon(
            Icons.location_on,
            size: 30,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              var typedName = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const CityScreen();
                  },
                ),
              );
              if (typedName != null) {
                var weatherData = await weather.getCityWeather(typedName);
                updateUI(weatherData);
              }
            },
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
            image: const NetworkImage('https://bit.ly/3Bp2K1G'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.4), BlendMode.dstIn),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SingleChildScrollView(
          child: LocationDetails(
            cityName: cityName,
            getBackgroundImage: getBackgroundImage,
            weatherIcon: weatherIcon,
            temperature: temperature,
            description: description,
            countryName: countryName,
            windSpeed: windSpeed,
            humidity: humidity,
            coordinateLon: coordinateLon,
            coordinateLat: coordinateLat,
            temperatureMin: temperatureMin,
            temperatureMax: temperatureMax,
          ),
        ),
      ),
    );
  }
}

class LocationDetails extends StatelessWidget {
  const LocationDetails({
    Key? key,
    required this.cityName,
    required this.getBackgroundImage,
    required this.weatherIcon,
    required this.temperature,
    required this.description,
    required this.countryName,
    required this.windSpeed,
    required this.humidity,
    required this.coordinateLon,
    required this.coordinateLat,
    required this.temperatureMin,
    required this.temperatureMax,
  }) : super(key: key);

  final String cityName;
  final String getBackgroundImage;
  final Image weatherIcon;
  final int temperature;
  final String description;
  final String countryName;
  final double windSpeed;
  final int humidity;
  final double coordinateLon;
  final double coordinateLat;
  final int temperatureMin;
  final int temperatureMax;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            '$cityName, $countryName',
            style: const TextStyle(
              fontSize: 45,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(height: 150, width: 1500, child: weatherIcon),
          const SizedBox(
            height: 10,
          ),
          Text(
            '$temperatureº',
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'H:$temperatureMaxº  L:$temperatureMinº',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade500,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            description,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade500,
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          _WeatherCard(
            weatherTypeName: 'Wind',
            weatherTypeContent: '$windSpeed km/h',
            icon: FontAwesomeIcons.wind,
          ),
          _WeatherCard(
            weatherTypeName: 'Humidity ',
            weatherTypeContent: '$humidity %',
            icon: FontAwesomeIcons.droplet,
          ),
          _WeatherCard(
            weatherTypeName: 'Coordinate',
            weatherTypeContent: '$coordinateLon,$coordinateLat',
            icon: FontAwesomeIcons.locationArrow,
          ),
          _WeatherCard(
            weatherTypeName: 'Temperature',
            weatherTypeContent: '$temperatureº',
            icon: FontAwesomeIcons.temperatureHalf,
          ),
        ],
      ),
    );
  }
}

class _WeatherCard extends StatelessWidget {
  final IconData icon;
  final String weatherTypeName;
  final String weatherTypeContent;

  const _WeatherCard({
    Key? key,
    required this.icon,
    required this.weatherTypeName,
    required this.weatherTypeContent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Row(
          children: [
            Icon(
              icon,
              size: 15,
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(weatherTypeName),
                  Text(
                    ' $weatherTypeContent',
                  )
                ],
              ),
            ),
          ],
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
      titlePadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      title: Align(
        alignment: Alignment.topRight,
        child: GestureDetector(
          child: const Icon(Icons.close),
          onTap: () => Navigator.pop(context),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(
            Icons.error,
            color: Colors.red,
            size: 55,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'ERROR 404',
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w400,
                fontFamily: 'Mulish',
                color: Colors.black),
          ),
          Text(
            "Couldn't fetch data...",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                fontFamily: 'Mulish',
                color: Colors.black),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 29,
          ),
          Text(
            "Check your internet connection or check city name input and try again.",
            style: TextStyle(
                fontSize: 15,
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

class Location {
  double? latitude;
  double? longitude;

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.medium);
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      ('unable to read ');
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }
}

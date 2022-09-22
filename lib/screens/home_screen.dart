import 'package:flutter/material.dart';
import 'package:getweather/screens/location_screen.dart';
import 'package:getweather/services/networking.dart';
import 'package:getweather/services/weather.dart';
import '../services/location.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const apiKey = '6242316f386a8a1d8f1580e186747cbb';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'HomeScreen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // put getLocation in the initState so as to get the location everytime I click hot restart.
  @override
  void initState() {
    super.initState();
    getLocationWeatherData();
    print('object');
  }

  void getLocationWeatherData() async {
    WeatherModel weatherModel = WeatherModel();
    var weatherData = await weatherModel.getLocationWeather();

      if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => LocationScreen(
          locationWeather: weatherData,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                'assets/images/locationScreen.jpg',
              ),
              fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            SpinKitSpinningLines(
              lineWidth: 3,
              color: Colors.black,
              size: 100.0,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Loading...',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}



// Scaffold(
//       backgroundColor: Colors.lightBlue.shade300,
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//         scrolledUnderElevation: 0,
//       ),
//       body: Container(
//         decoration: const BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage('assets/images/locationScreen.jpg'),
//             fit: BoxFit.cover,
//           ),
//         ),
//         constraints: BoxConstraints.expand(),

//         child: SafeArea(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: const [
//               SizedBox(
//                 height: 20,
//               ),
//               Text(
//                 'Loading...',
//                 style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//               )
//             ],
//           ),
//         ),
//       ),
//     );






// Here you call the Weather API through HTTP as Http.
//build a function to get API data firstly.
//put the getWeatherData inside the build method so it refreshes everytime the screen is buildt.


//  image: NetworkImage('https://bit.ly/3xzgaa4')
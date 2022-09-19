import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CityScreen extends StatefulWidget {
  static const String routeName = 'CityScreen';
  const CityScreen({Key? key}) : super(key: key);

  @override
  State<CityScreen> createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage('https://bit.ly/3xzgaa4'),
          ),
        ),
        child: const _GetWeatherTextField(),
      ),
    );
  }
}

class _GetWeatherTextField extends StatelessWidget {
  const _GetWeatherTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 30,
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),

          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    fillColor: Colors.white.withOpacity(0.8),
                    filled: true,
                    hintText: 'Search for a city',
                    prefixIcon: const Icon(
                      Icons.location_city_outlined,
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(
                        23,
                      ),
                    ),
                  ),
                  onChanged: ((value) {
                    print(value);
                  }),
                ),
              ],
            ),
          ),
          // const SizedBox(
          //   height: 50,
          // ),
          TextButton(
            onPressed: () {},
            child: Text(
              'Get Weather',
              style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade900),
            ),
          ),
        ],
      ),
    );
  }
}


// CityImage()async{
//   await NetworkImage('https://bit.ly/3xzgaa4');
// }


// TextButton(
//           onPressed: () => Navigator.of(context).pop(),
//           child: const Icon(
//             Icons.arrow_back,
//             color: Colors.black,
//             size: 30,
//           ),
//         ),
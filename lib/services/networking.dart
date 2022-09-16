import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NetworkHelper {
  String url;

  NetworkHelper(this.url);

  Future getNetworkData() async {
    http.Response apiResponse = await http.get(
      Uri.parse(url),
    );
    if (apiResponse.statusCode == 200) {
      //apiResponde.body shows the body of the given API
      String data = apiResponse.body;
     return jsonDecode(data);

 

    
    } else {
      return Column(
        children: const [
          Text(
              'Unable to connect to the internet. Please check your connect and try again')
        ],
      );
      print(apiResponse.statusCode);
    }
  }
}



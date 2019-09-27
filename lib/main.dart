import 'package:flutter/material.dart';
import 'package:flutter_weather/page/city/CityWidget.dart';

import 'page/weather/WeatherWidget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WeatherWidget("绵阳"),
    );
  }
}




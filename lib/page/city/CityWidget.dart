import 'package:flutter/material.dart';
import 'package:flutter_weather/page/city/CityData.dart';
import 'package:flutter_weather/page/weather/WeatherWidget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class CityWidget extends StatefulWidget {
  @override
  _CityWidgetState createState() => _CityWidgetState();
}

class _CityWidgetState extends State<CityWidget> {

  List<CityData> cityList = new List<CityData>();

  @override
  void initState() {
    super.initState();
    _getCityList();
  }

  _getCityList() async{
    List<CityData> citys = await _fetchCityList();
    setState(() {
      cityList = citys;
    });
  }

  Future<List<CityData>>_fetchCityList() async {
    final response=  await http.get('https://search.heweather.net/top?group=cn&key=2bee22d649c540e0837500637b0aa8de');

    List<CityData> cityList = new List<CityData>();

    if(response.statusCode == 200){
      Map<String,dynamic> result = json.decode(response.body);
      for(dynamic data in result['HeWeather6'][0]['basic']){
          CityData cityData = CityData(data['location']);
          cityList.add(cityData);
      }
      return cityList;

    }else{
      return cityList;
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('热门城市选择'),
        centerTitle: true,
        leading: GestureDetector(
          child: Icon(Icons.arrow_back),
          onTap: (){
            Navigator.of(context).pop();
          },
        ) ,
      ),
      body: Container(
        child: ListView.builder(
            itemCount: cityList.length,
            itemBuilder: (BuildContext context,int index){
              return ListTile(
                title: GestureDetector(
                  child: Text(cityList[index].cityName),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => WeatherWidget(cityList[index].cityName)));
                  },
                ),
              );
            }
        ),
      ),
    );
  }
}

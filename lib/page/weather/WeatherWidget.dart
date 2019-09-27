import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_weather/page/BgImg.dart';
import 'package:flutter_weather/page/city/CityWidget.dart';
import 'package:flutter_weather/page/weather/WeatherData.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class WeatherWidget extends StatefulWidget {
  String cityName;

  WeatherWidget(this.cityName,{Key key}): super(key:key);

  @override
  _WeatherWidgetState createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
   WeatherData weather = WeatherData.empty();

  List<String> attributes=new List<String>();
  List<String> descriptions= ['体感温度','降水量','大气压强','能见度','风向角度','风向','风力','风速'];
  List<IconData> icons=[Icons.ac_unit,Icons.grain,Icons.loyalty,Icons.remove_red_eye,Icons.style,Icons.explore,Icons.assistant_photo,Icons.brightness_high];
//  String bgUrl="images/weather_bg.jpg";
  String bgUrl="https://upload-images.jianshu.io/upload_images/15706836-14eb91d58dcd637a.jpg?imageMogr2/auto-orient/strip|imageView2/2/w/1059/format/webp";
  //数据的获取

  @override
  void initState() {
    super.initState();
    _getWeather();
  }

  _getWeather() async{
      WeatherData data = await _fetchWeather();
      BgImg bgImg = await _fetchBgUrl();
      setState(() {
        weather = data;
        attributes=[weather?.fl,weather?.pcpn,weather?.pres,weather?.vis,weather?.wind_deg,weather?.wind_dir,weather?.wind_sc,weather?.wind_spd];
        bgUrl=bgImg.url;
      });
  }

   /**
    * 获取必应图片
    */
   Future<BgImg>_fetchBgUrl() async {
      final response1= await http.get('https://cn.bing.com/HPImageArchive.aspx?format=js&idx=0&n=1');
      BgImg bgImg = BgImg.fromJson(json.decode(response1.body));
      return bgImg;
   }

  Future<WeatherData> _fetchWeather() async{
      final response = await http.get('https://free-api.heweather.net/s6/weather/now?location=${widget.cityName}&key=2bee22d649c540e0837500637b0aa8de');
      
      if(response.statusCode == 200){
        return WeatherData.fromJson(json.decode(response.body));
      }else{
        return WeatherData.empty();
      }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child:ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text('尹磊'),
                accountEmail: Text('1099129793@qq.com'),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage('https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2777233881,1106483217&fm=26&gp=0.jpg',scale: 1.0 ),
                ),
                onDetailsPressed: (){

                },
                otherAccountsPictures: <Widget>[
                  Container(child: Image.network('https://profile.csdnimg.cn/D/C/4/1_qq_39969226',fit: BoxFit.fill,),),
                  Container(child: Image.network('https://cdn.jsdelivr.net/gh/flutterchina/website@1.0/images/homepage/header-illustration.png',fit: BoxFit.fill,),),
                ],
                decoration: BoxDecoration(
                  color: Colors.tealAccent[400],
                  image: DecorationImage(
                    image: NetworkImage('https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3577773561,2706257243&fm=26&gp=0.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              ListTile(title: Text('特别说明：本APP提供每日一图'),)
            ],
          ),
        ),
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
//            Image.asset(bgUrl,fit: BoxFit.fitHeight,),
           Image.network(bgUrl,fit: BoxFit.fitHeight,),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 40.0),
                  child: Text(
                    widget.cityName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                    ),
                  ),
                ),

                //第2部分
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 100.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        weather?.tmp,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 80.0,
                        ),
                      ),
                      Text(
                        weather?.cond_txt,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 45.0,
                        ),
                      ),
                      Text(
                        '相对湿度:'+weather?.hum,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30.0,
                        ),
                      ),

                    ],
                  ),
                ),

                RaisedButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CityWidget()));
                  },
                  color: Colors.blueAccent[400],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  textColor: Colors.white,
                  child: Text('切换城市'),
                ),

              ],
            ),

            Container(
              //这里有BUG，就是positioned组件失效。所以我这里用的padding，设置为屏幕的3/2的高度
              //解决bug:使用Align组件。
              padding: EdgeInsets.only(top:(MediaQuery.of(context).size.height)*2/3),
              child: otherInformation(),
            ),


          Align(
            alignment: FractionalOffset.bottomCenter,
            child: Container(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text('【Flutter制作】APP使用必应接口、和风天气接口.',style: TextStyle(fontSize: 15,color: Colors.white),) ,
            ),
          ),
          ],
        ),
    );
  }

  otherInformation() {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: attributes?.length,
        itemBuilder: (BuildContext context,int index){
          return  Padding(
            padding: EdgeInsets.only(left: 10,right: 5),
            child:Column(
              children: <Widget>[
                Text(
                  attributes[index],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 21.0,
                  ),
                ),
                Icon(icons[index],color: Colors.white,),
                Text(
                  descriptions[index],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                  ),
                ),
              ],
            ),
          );
        }
    );
  }

}




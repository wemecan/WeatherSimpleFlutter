class WeatherData{
  String cloud;//云量
  String cond_txt;//实况天气状况描述
  String fl;//体感温度，默认单位：摄氏度
  String hum;//相对湿度
  String pcpn;//降水量
  String pres;//大气压强
  String tmp;//温度，默认单位：摄氏度
  String vis;//能见度，默认单位：公里
  String wind_deg;//风向360角度
  String wind_dir;//风向
  String wind_sc;//风力
  String wind_spd;//风速，公里/小时

  WeatherData({this.cloud, this.cond_txt, this.fl, this.hum, this.pcpn,
      this.pres, this.tmp, this.vis, this.wind_deg, this.wind_dir, this.wind_sc,
      this.wind_spd});

  factory WeatherData.fromJson(Map<String,dynamic> json){
    return WeatherData(
      cloud: json['HeWeather6'][0]['now']['cloud'],
      cond_txt: json['HeWeather6'][0]['now']['cond_txt'],
      fl: json['HeWeather6'][0]['now']['fl']+'℃',
      hum: json['HeWeather6'][0]['now']['hum'],
      pcpn: json['HeWeather6'][0]['now']['pcpn'],
      pres: json['HeWeather6'][0]['now']['pres'],
      tmp: json['HeWeather6'][0]['now']['tmp']+'℃',
      vis: json['HeWeather6'][0]['now']['vis']+'公里',
      wind_deg: json['HeWeather6'][0]['now']['wind_deg']+'角度',
      wind_dir: json['HeWeather6'][0]['now']['wind_dir'],
      wind_sc: json['HeWeather6'][0]['now']['wind_sc']+'级',
      wind_spd: json['HeWeather6'][0]['now']['wind_spd']+'公里/小时',
    );
  }

  factory WeatherData.empty(){
    return WeatherData(
      cloud: "",
      cond_txt: "",
      fl: "",
      hum: "",
      pcpn: "",
      pres: "",
      tmp: "",
      vis: "",
      wind_deg: "",
      wind_dir: "",
      wind_sc: "",
      wind_spd: "",
    );
  }


}
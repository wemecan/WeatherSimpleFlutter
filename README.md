# WeatherSimpleFlutter
简易版天气APP(Flutter制作):使用和风天气接口、必应每日一图接口

这是一个简易版的Flutter App。练手使用。
接口：
- 必应每日一图：https://cn.bing.com/HPImageArchive.aspx?format=js&idx=0&n=1
- 和风天气：https://dev.heweather.com/

![avatar](https://github.com/LeiLeiOfJava/WeatherSimpleFlutter/blob/master/result1.png)
![avatar](https://github.com/LeiLeiOfJava/WeatherSimpleFlutter/blob/master/result2.png)
![avatar](https://github.com/LeiLeiOfJava/WeatherSimpleFlutter/blob/master/result3.png)

## 待扩展的问题是：Drawer组件还未完善，很简陋。
另外，还有个问题，就是和风天气的城市接口，所展示的热门城市太少，不满足现实需求。
但和风天气提供了查询城市接口，在接口中，传递location参数，默认示例是：xxxlocation=mianyang || xxxlocation=绵阳
所以，可以提供输入widget，获取用户输入的城市。
还有个没做的是获取当前地理位置，以用户的实际地理位置展示相应的天气状况。
这里的思路是：
- 方法1：dart pub中有提供了高德地图插件。
- 方法2：Flutter 与Native通信，通过平台通道，在Native端获取用户设备的地理位置，然后传递给Flutter中的接口进行展示也可。

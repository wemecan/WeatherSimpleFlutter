class BgImg{
  String url;

  BgImg({this.url});

  factory BgImg.fromJson(Map<String,dynamic> json){
    var originUrl =  'https://www.bing.com/'+json['images'][0]['url'];
    String infactUrl = originUrl.replaceFirst("1920x1080","480x800");
    return BgImg(
      url: infactUrl,
    );
  }
}

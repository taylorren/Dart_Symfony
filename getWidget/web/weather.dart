import 'package:polymer/polymer.dart';
import 'dart:html';
import 'dart:convert';


/**
 * A Polymer click counter element.
 */
@CustomTag('weather-tag')
class WeatherTag extends PolymerElement {
  @published String code, city;
  @published bool one=true;
  
  @published Weather1 w1;
  @published Weather2 w2; 

  WeatherTag.created() : super.created() {
    var root=getShadowRoot('weather-tag');
    root.applyAuthorStyles=true;
    
    getWeather();
  }

  void getWeather()
  {
    var path1='http://rsywx/app_dev.php/json/weather/1/$code';
    var path2='http://rsywx/app_dev.php/json/weather/2/$city';
    
  
    HttpRequest.getString(path1).then((String res)=>processWeather1(res));
    HttpRequest.getString(path2).then((String res)=>processWeather2(res));
    
    if(one)
      one=false;
    else
      one=true;
  }
  
  void processWeather1(String res)
  {
    w1=new Weather1.created(res);    
  }
  
  void processWeather2(String res)
  {
    w2=new Weather2.created(res);
  }
}

class Weather1
{
  @observable var city, week, weather, img, imgdesc, temp;
  
  Weather1.created(String s)
  {
    Map w=JSON.decode(s);
    var wi=w['weatherinfo'];
    this.city=wi['city'];
    this.week=wi['week'];
    this.temp=wi['temp1'];
    this.weather=wi['weather1'];
    this.img=wi['img1'];
    this.imgdesc=wi['img_title1'];
  }
}

class Weather2
{
  @observable var desc, city, temp, humidity;
  Weather2.created(String s)
  {
    Map w=JSON.decode(s);
    this.temp=w['main']['temp'].toStringAsFixed(1);
    this.humidity=w['main']['humidity'];
    this.city=w['name'];
    this.desc=w['weather'][0]['description']; 
  }
}

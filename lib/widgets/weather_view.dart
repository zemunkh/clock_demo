import 'package:flutter/material.dart';
import 'dart:async';
import 'package:weather/weather_library.dart';
import 'package:geolocator/geolocator.dart';


class WeatherView extends StatefulWidget {
  @override
  _WeatherViewState createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {

  WeatherStation ws;
  int temperature = 0;
  String weatherIcon = '';
  String weatherMain = '';
  String url;
  String country = 'USA';
  String city = 'California';
  String imgDir = 'assets/images/clear-day.png';
  
  bool isNight = false;
  bool isShowTick = true;
  String apiKey = "f6199887e28da9ef07f15262b43b25f5";



  String _getWeatherIcon(String iconCode) {
    var hour = DateTime.now().hour;
    if(hour > 7 && hour < 19) {
      isNight = false;
    } else {
      isNight = true;
    }

    String img = '';
    switch(iconCode) {
      case '01d': // clear sky
        {
          if(isNight) {
            img = 'assets/images/clear-night.png';
          } else {
            img = 'assets/images/clear-day.png';
          }
        }
        break;
      case '02d': // few clouds
        {
          if(isNight) {
            img = 'assets/images/few-cloud-night.png';
          } else {
            img = 'assets/images/few-cloud-day.png';
          } 
        }
        break;
      case '03d': // scattered clouds
        {
          if(isNight) {
            img = 'assets/images/few-cloud-night.png';
          } else {
            img = 'assets/images/few-cloud-day.png';
          } 
        }
        break;
      case '04d': // broken clouds
        {
          if(isNight) {
            img = 'assets/images/broken-cloud.png';
          } else {
            img = 'assets/images/few-cloud-day.png';
          }   
        }   
        break;
      case '09d': // shower rain
        img = 'assets/images/shower-rain.png';
        break;
      case '10d': // rain
        {
          if(isNight) {
            img = 'assets/images/rain-night.png';
          } else {
            img = 'assets/images/rain-day.png';
          }
        }  
        break;
      case '11d': // thunderstorm
        img = 'assets/images/thunderstorm.png';
        break;
      case '13d': // snow
        img = 'assets/images/snow.png';
        break;
      case '50d': // mist
        img = 'assets/images/mist.png';
        break;
      default: 
        {
          if(isNight) {
            img = 'assets/images/clear-night.png';
          } else {
            img = 'assets/images/clear-day.png';
          }
        }
    }

    return img;
  }

  Future<Null> _getTemperature() async {
    double lat, lng;

    GeolocationStatus geolocationStatus  = await Geolocator().checkGeolocationPermissionStatus();

    if(geolocationStatus == GeolocationStatus.granted || geolocationStatus == GeolocationStatus.denied) {
      await Geolocator()
        .getLastKnownPosition(desiredAccuracy: LocationAccuracy.high)
        .then((position) async {
          if(position != null) {
            lat = position.latitude;
            lng = position.longitude;
            print("Lat: $lat");
            print("Lng: $lng");

          } else {
            lat = 47.886398;
            lng = 106.905746;
            print("Cannot get exact location");
          }
          
          await Geolocator().placemarkFromCoordinates(lat, lng).then((placemark){
            print("Placemark1: ${placemark[0].country}");
            print("Placemark2: ${placemark[0].administrativeArea}");
            setState(() {
              city = placemark[0].administrativeArea;
              country = placemark[0].country;
            });
          });

          // print("Location is granted somehow");
          var iconDir = '';
          try {
            Weather weather = await ws.currentWeather(lat, lng);
            iconDir = _getWeatherIcon(weather.weatherIcon);
            setState(() {
              temperature = weather.temperature.celsius.round();
              imgDir = iconDir;
              weatherMain = weather.weatherMain;
            });
            print("Weather image: $imgDir");
          } catch(e) {
            print('Error: $e');
          }
        }).catchError((err) {
          print("Error get location: $err");
        });
    } else {
      print("Location is not granted");
      lat = 47.886398;
      lng = 106.905746;
      var iconDir = '';
      try {
        Weather weather = await ws.currentWeather(lat, lng);
        iconDir = _getWeatherIcon(weather.weatherIcon);
        setState(() {
          temperature = weather.temperature.celsius.round();
          imgDir = iconDir;
          weatherMain = weather.weatherMain;
        });
        print("Weather image: $imgDir");
      } catch(e) {
        print('Error: $e');
      }
    }
  }

  timedFetch() {
    Timer.periodic(Duration(minutes: 30), (timer) {
      _getTemperature();
    });
  }

  @override
  void initState() {
    super.initState();
    ws = new WeatherStation(apiKey);
    _getTemperature();
    timedFetch();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
              Radius.circular(10),
          ),
          side: BorderSide(width: 0, color: Colors.black), 
        ),
        shadows: [BoxShadow(
          offset: const Offset(10, 10),
          blurRadius: 4,
          spreadRadius: 0,
          color: Color.fromARGB(50, 148, 148, 148)
        )]
      ),
      child: Column(
        children: <Widget>[
          Text(
            city,
            style: TextStyle(
              fontSize: 32,
              fontFamily: 'Montserrat',
              color: Color(0xFF262269)
            ),
          ),
          Center(
            child: Image.asset(imgDir),
          ),
          Text(
            weatherMain,
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Avenir',
              fontWeight: FontWeight.w700,
              color: Color(0xFF262269)
            ),
          ),
          Text(
            temperature == null ? 'NaN' : '${temperature.toString()}°',
            style: TextStyle(
              fontSize: 36,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherPage extends StatefulWidget {
  Position position;
  WeatherPage(this.position);
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  var weather;
  bool loading = false;
  static const String API_KEY = "f43fe4a3fb5a7b285f72ea7fec352919";
  Future fetchalldata() async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=${widget.position.latitude}&lon=${widget.position.longitude}&units=metric&appid=$API_KEY'));
    setState(() {
      loading = true;
      weather = jsonDecode(response.body);
    });
    print(weather);
    return jsonDecode(response.body);
  }

  String getClockInUtcPlus5Hours(int timeSinceEpochInSec) {
    final time = DateTime.fromMillisecondsSinceEpoch(timeSinceEpochInSec * 1000,
            isUtc: true)
        .add(const Duration(hours: 6));
    return '${time.hour}:${time.minute}:${time.second}';
  }

  @override
  void initState() {
    super.initState();
    fetchalldata();
  }

  @override
  Widget build(BuildContext context) {
    if (loading == true) {
      return Scaffold(
        appBar: AppBar(title: Text('Weather Page')),
        body: Column(
          children: [
            Text('latitude:' +
                weather['coord']['lat'].toString() +
                ' longitude: ' +
                weather['coord']['lon'].toString()),
            Text('description :' + weather['weather'][0]['description']),
            Text('temperature :' + weather['main']['temp'].toString() + '°C'),
            Text('feels_like : ' +
                weather['main']['feels_like'].toString() +
                '°C'),
            Text('temperature_min :' +
                weather['main']['temp_min'].toString() +
                '°C'),
            Text('temperature_max :' +
                weather['main']['temp_max'].toString() +
                '°C'),
            Text(
                'pressure :' + weather['main']['pressure'].toString() + ' hPa'),
            Text('humidity :' + weather['main']['humidity'].toString() + '%'),
            Text('visibility :' + weather['visibility'].toString()),
            Text('wind_speed :' +
                weather['wind']['speed'].toString() +
                ' meter/sec'),
            Text('country :' + weather['sys']['country']),
            Text('sunrise :' +
                getClockInUtcPlus5Hours(weather['sys']['sunrise'])),
            Text(
                'sunset :' + getClockInUtcPlus5Hours(weather['sys']['sunset'])),
            Text('location (approx 1km) :' + weather['name']),
          ],
        ),
      );
    } else {
      return Scaffold(
          appBar: AppBar(title: Text('Weather Page')),
          body: Center(child: CircularProgressIndicator()));
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:news_app_user/Database.dart';
import 'package:news_app_user/Screens/HoroscopeDataPage.dart';

class HoroscopePage extends StatefulWidget {
  @override
  _HoroscopePageState createState() => _HoroscopePageState();
}

class _HoroscopePageState extends State<HoroscopePage> {
  List<String> months = [
    'aquarius',
    'pisces',
    'aries',
    'taurus',
    'gemini',
    'cancer',
    'leo',
    'virgo',
    'libra',
    'scorpio',
    'sagittarius',
    'capricorn'
  ];
  late String data;
  DateTime currentDate = DateTime.now();
  String uid = FirebaseDb().getuid().toString();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        crossAxisCount: 3,
        children: List.generate(months.length, (index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HoroscopeDataPage(months[index])));
            },
            child: Container(
                child: Column(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/${months[index]}.jpg'),
                ),
                Text(months[index])
              ],
            )),
          );
        }),
      ),
    );
  }
}

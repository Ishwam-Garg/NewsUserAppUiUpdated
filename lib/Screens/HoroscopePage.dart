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
    'मेष',
    'वृषभ',
    'मिथुन',
    'कर्क',
    'सिंह',
    'कन्या',
    'तुला',
    'वृश्चिक',
    'धनुराशि',
    'मकर',
    'कुंभ',
    'मीन',
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
                  radius: 30,
                  backgroundImage: AssetImage('assets/${months[index]}.jpg'),
                ),
                SizedBox(height: 10,),
                Text(months[index],style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),)
              ],
            )),
          );
        }),
      ),
    );
  }
}

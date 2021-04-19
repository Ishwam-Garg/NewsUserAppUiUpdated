import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app_user/Database.dart';
import 'package:news_app_user/HomePage.dart';
import 'package:news_app_user/Screens/BookmarkPage.dart';
import 'package:news_app_user/Screens/BuisnessPage.dart';
import 'package:news_app_user/Screens/ChuruPage.dart';
import 'package:news_app_user/Screens/CovidDataPage.dart';
import 'package:news_app_user/Screens/CricketnewsPage.dart';
import 'package:news_app_user/Screens/EntertainmentPage.dart';
import 'package:news_app_user/Screens/HoroscopeNewsPage.dart';
import 'package:news_app_user/Screens/HoroscopePage.dart';
import 'package:news_app_user/Screens/InternationalPage.dart';
import 'package:news_app_user/Screens/LiveScorePage.dart';
import 'package:news_app_user/Screens/LoginPage.dart';
import 'package:news_app_user/Screens/NationalPage.dart';
import 'package:news_app_user/Screens/PhoneAuth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:news_app_user/Screens/RajasthanPage.dart';
import 'package:news_app_user/Screens/SportsPage.dart';
import 'package:news_app_user/Screens/WeatherPage.dart';

class PageControllerScreen extends StatefulWidget {
  @override
  _PageControllerScreenState createState() => _PageControllerScreenState();
}

class _PageControllerScreenState extends State<PageControllerScreen> {
  late Position position;
  getcurrentlocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    print(position.latitude.toString() + ', ' + position.longitude.toString());
  }

  late List bookmarkid = [];
  var db;
  var id;
  fetchids() async {
    db = await FirebaseDb().main2();
    id = await FirebaseDb().bookmarksids(db);
    for (int i = 0; i < id.length; i++) {
      bookmarkid.add(id[i]['id']);
    }
  }

  @override
  void initState() {
    super.initState();
    getcurrentlocation();
    fetchids();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 12,
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize:
                Size(MediaQuery.of(context).size.width.toDouble(), 80),
            child: AppBar(
              iconTheme: IconThemeData(color: Colors.white),
              title: Text('जयपुर टाइम्स'),
              centerTitle: true,
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    await FirebaseDb().signout();
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => PhoneAuth()),
                        (Route<dynamic> route) => false);
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.device_thermostat,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WeatherPage(position)));
                  },
                ),
              ],
              bottom: TabBar(
                labelColor: Colors.white,
                isScrollable: true,
                labelStyle: TextStyle(fontSize: 18),
                physics: ScrollPhysics(),
                tabs: <Widget>[
                  Tab(
                    text: 'चुरू',
                  ),
                  Tab(
                    child: Container(
                      child: Text('राजस्थान'),
                    ),
                  ),
                  Tab(
                    child: Container(
                      child: Text('कोविड डेटा'),
                    ),
                  ),
                  Tab(
                    child: Container(
                      child: Text('राष्ट्रीय'),
                    ),
                  ),
                  Tab(
                    child: Container(
                      child: Text('अंतरराष्ट्रीय'),
                    ),
                  ),
                  Tab(
                    child: Container(
                      child: Text('खेल'),
                    ),
                  ),
                  Tab(
                    child: Container(
                      child: Text('मनोरंजन'),
                    ),
                  ),
                  Tab(
                    child: Container(
                      child: Text('व्यापार'),
                    ),
                  ),
                  Tab(
                    child: Container(
                      child: Text('राशिफल'),
                    ),
                  ),
                  Tab(
                    child: Container(
                      child: Text("आज का राशिफल"),
                    ),
                  ),
                  Tab(
                    child: Container(
                      child: Text('बुकमार्क'),
                    ),
                  ),
                  Tab(
                    child: Container(
                      child: Text('क्रिकेट स्कोर'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: TabBarView(
            physics: ScrollPhysics(),
            children: <Widget>[
              ChuruPage(bookmarkid),
              RajasthanPage(bookmarkid),
              CovidDataPage(),
              NationalPage(bookmarkid),
              InternationalPage(bookmarkid),
              SportsPage(bookmarkid),
              EntertainmentPage(bookmarkid),
              BuisnessPage(bookmarkid),
              HoroscopeNewsPage(bookmarkid),
              HoroscopePage(),
              BookmarkPage(bookmarkid),
              CricketNews(),
            ],
          )),
    );
  }
}

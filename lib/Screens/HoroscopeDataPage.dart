import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:news_app_user/Database.dart';

class HoroscopeDataPage extends StatefulWidget {
  String sign;
  HoroscopeDataPage(this.sign);
  @override
  _HoroscopeDataState createState() => _HoroscopeDataState();
}

class _HoroscopeDataState extends State<HoroscopeDataPage> {
  String uid = FirebaseDb().getuid().toString();
  late String data;
  DateTime currentDate = DateTime.now();
  late String updateddata;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.sign),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection(widget.sign)
            .orderBy('date', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: Text('No Data available'));
          } else {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data!.docs[index];
                  return GestureDetector(
                    child: Card(
                      margin: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Text(ds['data']),
                          Text(ds['date'].toString()),
                        ],
                      ),
                    ),
                  );
                });
          }
        },
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:news_app_user/Database.dart';
import 'package:news_app_user/Screens/BlogDataPage.dart';

class SportsPage extends StatefulWidget {
  List id;
  SportsPage(this.id);
  @override
  _FashionPageState createState() => _FashionPageState();
}

class _FashionPageState extends State<SportsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('खेल')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text(
              'No Data...',
            );
          } else {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data!.docs[index];
                  String docid = ds.id;
                  FirebaseDb().updatevalue(docid, 'impression');
                  return GestureDetector(
                    onTap: () async {
                      await FirebaseDb().updatevalue(docid, 'views');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  BlogDataPage(ds, widget.id)));
                    },
                    child: Material(
                      elevation: 10,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Container(
                          margin: EdgeInsets.only(bottom: 10),
                          padding: EdgeInsets.symmetric(vertical: 10),
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(width: 2, color: Colors.grey),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                          ds['image_url']),
                                      fit: BoxFit.fill),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 20, right: 20),
                                child: Text(
                                  (ds['title']).toString(),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 20, right: 20),
                                child: Text(
                                  (ds['description']).toString(),
                                  maxLines: 5,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 20, right: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      ds['category'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black.withOpacity(0.4)),
                                    ),
                                    Text(ds['date'],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Colors.black.withOpacity(0.4))),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
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

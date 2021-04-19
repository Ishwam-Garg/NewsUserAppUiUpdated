import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class DataViewPage extends StatelessWidget {
  var data;
  DataViewPage(this.data);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Text(data.title.toString()),
          Container(
            child: CachedNetworkImage(
              imageUrl: data.urlToImage.toString(),
            ),
          ),
          Text(data.content.toString()),
        ],
      ),
    ));
  }
}

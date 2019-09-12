import 'package:flutter/material.dart';
import 'package:idiom_flutter/vo/idiomvo.dart';
import 'package:idiom_flutter/widget/idiom_detail.dart';

class IdiomDetailPage extends StatelessWidget{

  final Idiom idiom;
   IdiomDetailPage({Key key,@required this.idiom}):super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('成语详情'),
        centerTitle: true,
      ),
      body: Container(
        child: ListView(
          padding: EdgeInsets.all(30),
          children: <Widget>[
            IdiomDetail(idiom),
          ],
        ),
      ),

    );
  }

}
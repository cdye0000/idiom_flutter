import 'package:data_plugin/bmob/bmob.dart';
import 'package:flutter/material.dart';
import 'package:idiom_flutter/file/file_download.dart';
import 'package:idiom_flutter/pages/home_page.dart';
import 'package:idiom_flutter/pages/search_idiom.dart';
import 'package:idiom_flutter/pages/start_page.dart';
import 'package:idiom_flutter/pages/update_data.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Bmob.initMasterKey('fee86001f87ffb30d7c090e2ddd25345', '986ace30998d6aa84f020bfe53db0055', '');
    return MaterialApp(
      title: 'Flutter Demo',
      routes: <String,WidgetBuilder>{
        'home':(BuildContext context)=>HomePage(),
        'search':(BuildContext context)=>SearchPage(),
        'file':(BuildContext context)=>FilePage(),
        'updatedata':(BuildContext context)=>UpDateDataPage(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StartPage(),
    );
  }
}



import 'dart:io';

import 'package:data_plugin/bmob/bmob_query.dart';
import 'package:data_plugin/data_plugin.dart';
import 'package:flutter/material.dart';
import 'package:idiom_flutter/db/db_idiom.dart';
import 'dart:math';
import 'package:idiom_flutter/vo/idiomvo.dart';
import 'package:idiom_flutter/vo/version.dart';
import 'package:package_info/package_info.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomePageState();
  }

}

class _HomePageState extends State<HomePage>{
  Idiom _idiomVo;
  IdiomDBUtils _dbUtils;
  bool firstChecked=false;



  _checkVersion(BuildContext context)async{
    BmobQuery<Version> query = BmobQuery();
    query.setOrder('versionCode');
    var list = await query.queryObjects();
    if(list!=null&&list.length>0){
      Version version=Version.fromJson(list[0]);
      int currentVersionCode=await _getCurrentVersion();
      SharedPreferences _sharedPreferences=await SharedPreferences.getInstance();
      _sharedPreferences.setInt('count', version.idiomCount);
      if(version.versionCode>currentVersionCode){
        _showUpdateApp(context,version.downloadUrl);
      }
    }else{

    }

  }
  Future<int>_getCurrentVersion() async{
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String _currentVersionCode = packageInfo.buildNumber;
    int currentVersionCode = int.parse(_currentVersionCode);
    return currentVersionCode;
  }

  Future<Idiom> _querySingle() async{
    var queryRandom=await _dbUtils.queryRandom();
    if(queryRandom!=null){
      return queryRandom;
    }else{
      SharedPreferences _sharedPreferences=await SharedPreferences.getInstance();
      int count=_sharedPreferences.getInt("count");
      if(count>0){
        Random random=new Random();
        BmobQuery<Idiom> query = BmobQuery();
        var list = await query.setSkip(random.nextInt(count)).setLimit(1).queryObjects();
        return Idiom.fromJson(list[0]);
      }else{

        return Idiom();
      }
    }

  }

   _change() async{
     Idiom idiomVo=await _querySingle();
    setState(() {
      _idiomVo=idiomVo;
    });
  }
  _querySingleAndsetState(){

    _querySingle().then((idiomVo){
      setState(() {
        _idiomVo=idiomVo;
      });
    });
  }
  _showUpdateApp(BuildContext context,String url){
    showDialog(context: context,builder: (context)=>AlertDialog(

      title: Text('发现新版本'),
      actions: <Widget>[
        FlatButton(onPressed: (){Navigator.of(context).pop();}, child: Text('取消')),
        FlatButton(onPressed: (){
          Navigator.of(context).pop();
          launch(url);

        }, child: Text('更新')),
      ],

    ));

  }
  _showSyncDb(BuildContext context){
    showDialog(context: context,builder: (context)=>AlertDialog(

      title: Text('同步数据到本地'),
      actions: <Widget>[
        FlatButton(onPressed: (){Navigator.of(context).pop();}, child: Text('取消')),
        FlatButton(onPressed: (){
          Navigator.of(context).pop();
          Navigator.pushNamed(context, 'file');
        }, child: Text('确定')),
      ],

    ));

  }
  _checkDb(BuildContext buildContext){
    _dbUtils.isDbExist().then((flag){
      if(flag){
        _querySingleAndsetState();
      }else{
        _showSyncDb(buildContext);
      }
    });
  }

  TextStyle titleStyle=TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );
  TextStyle wordStyle=TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );


  @override
  initState()  {
    super.initState();
    _dbUtils=IdiomDBUtils();
    firstChecked=false;

  }

  @override
  Widget build(BuildContext context) {
    if(!firstChecked){
      _checkVersion(context);
      _checkDb(context);
      firstChecked=true;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('随机成语'),
        centerTitle: true,
        actions: <Widget>[
          GestureDetector(

            child: Padding(padding: EdgeInsets.only(right: 10,left: 10),child: Icon(Icons.search),),
            onTap: (){
              Navigator.pushNamed(context, 'search');

            },
          )
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text('随便看看',style: TextStyle(fontSize: 14,),),
                ),
                GestureDetector(
                  child: Padding(padding: EdgeInsets.only(right: 10),child: Row(
                    children: <Widget>[
                      Icon(Icons.refresh),
                      Text('换一换')
                    ],
                  ),),
                  onTap:_change,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 30),
            child: Text('${_idiomVo==null?'':_idiomVo.word}',style: wordStyle,),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child:  Text('拼音',style: titleStyle,),
          ),
          Text('${_idiomVo==null?'无':_idiomVo.pinyin}'),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text('解释',style: titleStyle,),
          ),
          Text('${_idiomVo==null?'无':_idiomVo.explanation}'),
          Container(
            margin: EdgeInsets.only(top: 10),
            child:  Text('出处',style: titleStyle,),
          ),
          Text('${_idiomVo==null?'无':_idiomVo.derivation}'),
          Container(
            margin: EdgeInsets.only(top: 10),
            child:  Text('示例',style: titleStyle,),
          ),
          Text('${_idiomVo==null?'无':_idiomVo.example}'),

        ],
      ),
    );
  }

}
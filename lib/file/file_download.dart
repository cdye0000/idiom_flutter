import 'package:data_plugin/data_plugin.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:idiom_flutter/vo/idiomvo.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:math';
class FilePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _FileState();
  }

}
class _FileState extends State<FilePage>{
  String url='http://pwoir4hbn.bkt.clouddn.com/idiom.db';
  String word;
  bool loading=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(onPressed: (){
              if(!loading){
                _clickDownload();
              }
            },child: Text(loading?'更新中':'更新数据'),

            ),
            RaisedButton(onPressed: (){
              _clickQuery();
            },child: Text('查询'),),
            Text('$word')
          ],
        ),
      )
    );
  }

  _clickDownload() async{
    String dbPath=await _databasePath('idiom.db');
//    String dbPath=await _databasePath('/sdcard/idiom.db');
    print(dbPath);
    _downloadFile(url,dbPath);
  }
  _clickQuery()async{
    Idiom idiomVo=await _queryRandom();
    setState(() {
      word=idiomVo.word;
    });
  }


  _downloadFile(String url,String path) async{

    int start=0;
    var tempDir = await getTemporaryDirectory();
    if(!tempDir.existsSync()){
      await tempDir.create(recursive:true);
    }
    var temppath=join(tempDir.path,'idiom_temp');
    var temppath1=join(tempDir.path,'idiom_temp1');
    if(File(temppath).existsSync()){
      File tempFile=File(temppath);
      int length= await tempFile.length();
      start=length;
    }else{
      await File(temppath).create(recursive: true);
    }
    if(!File(temppath1).existsSync()){
      await File(temppath1).create(recursive: true);

    }

    print('下载start=$start');

    if(url==null){
      DataPlugin.toast('未找到文件');
      print('未找到文件');
      return;
    }
    Dio dio=Dio();
    try{
      Response<dynamic> response=await dio.download(url, temppath1,onProgress: (int received, int total){
        print('received=$received  total=$total');
      },options: Options(
        headers: {"range": "bytes=$start-"},
      ));
      await _mergeTempFiles(temppath, temppath1);
      await _mergeTempFiles(path, temppath);
      DataPlugin.toast('下载完成，请重启app');
//      DataPlugin.toast('$path');
//      print(response.statusCode);
      print('下载完成');
      _saveTime();
      _clickQuery();
    }on DioError catch (error){
      print(error);
      DataPlugin.toast('${error}');
      File file=new File(path);
      if(file.existsSync()){
        file.deleteSync();
      }
      file.createSync();
      _mergeTempFiles(temppath, temppath1);
      _mergeTempFiles(path, temppath);

    }



  }
  _saveTime()async{
    SharedPreferences _sharedPreferences=await SharedPreferences.getInstance();
    _sharedPreferences.setString('dataUpdateTime', DateTime.now().toIso8601String());


  }
  Future<String> _databasePath(String name) async{
    var dataBasePath = (await getDatabasesPath());
    String path=join(dataBasePath,name);
    if(await Directory(dirname(path)).exists()){
      deleteDatabase(path);
    }else{
      await Directory(dirname(path)).create(recursive: true);
    }

    return path;
  }


  _mergeTempFiles(String savePath,String tempPath) async{
    print('savePath=$savePath');
    print('tempPath=$tempPath');
    File file=File(savePath);
    File temp = File(tempPath);
    IOSink ioSink= file.openWrite(mode: FileMode.writeOnlyAppend);
    await ioSink.addStream(temp.openRead());
    await temp.delete();
    await ioSink.close();
  }
  Future<Idiom> _queryRandom() async{
    Database database=await openDatabase(join((await getDatabasesPath()),'idiom.db'));
    String sql='select * from idiom where _id=?';
    String sqlCount='SELECT COUNT(*) FROM idiom';
    int count = Sqflite.firstIntValue(await database.rawQuery(sqlCount));
    var list = await database.rawQuery(sql,['${Random().nextInt(count)}']);
    Idiom idiomVo=Idiom();
    if(list!=null&&list.length!=0){
      idiomVo.word=list[0]['word'];
      idiomVo.pinyin=list[0]['pinyin'];
    }
    return idiomVo;
  }


}
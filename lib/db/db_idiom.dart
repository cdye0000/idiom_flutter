import 'dart:io';
import 'dart:math';

import 'package:data_plugin/bmob/bmob_query.dart';
import 'package:idiom_flutter/db/datebase_helper.dart';
import 'package:idiom_flutter/vo/idiomvo.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class IdiomDBUtils{
  factory IdiomDBUtils()=>_shareInstance();
  static IdiomDBUtils _instance;

  IdiomDBUtils._();
  static IdiomDBUtils _shareInstance(){
    if(_instance==null){
      _instance=IdiomDBUtils._();
    }
    return _instance;

  }

  Future<Idiom> queryRandom() async{
    Idiom idiomVo=Idiom();
    try{
    Database database=await openDatabase(join(await getDatabasesPath(),'idiom.db'));
    String sql='select * from idiom where _id=?';
    String sqlCount='SELECT COUNT(*) FROM idiom';

    int count = Sqflite.firstIntValue(await database.rawQuery(sqlCount));
    var list = await database.rawQuery(sql,['${Random().nextInt(count)}']);
    if(list!=null&&list.length!=0){
//      idiomVo.word=list[0]['word'];
//      idiomVo.pinyin=list[0]['pinyin'];
      idiomVo=Idiom.fromJson(list[0]);

    }}catch(e){
      return null;
    }
    return idiomVo;
  }


  Future<List<Idiom>> queryList({int pageNumber = 1, int pageSize = 15,String keywords=''}) async {
    DataBaseHelper dataBaseHelper=DataBaseHelper();
    Database db=await dataBaseHelper.db;
    if (pageNumber < 1) {
      pageNumber = 1;
    }
    if (pageSize <= 0) {
      pageSize = 15;
    }
    String whereCondition="where word like '%$keywords%'";
    String limit = '${(pageNumber - 1) * pageSize},$pageSize';
    String sql = 'select * from idiom ${keywords==''||keywords==null?'':whereCondition} limit $limit';
    var list = await db.rawQuery(sql);
    return list.map((map){
      return Idiom.fromJson(map);
    }).toList();
  }

  Future<int> save(Idiom idiom)async{
    DataBaseHelper dataBaseHelper=DataBaseHelper();
    Database db=await dataBaseHelper.db;
    int res=await db.insert('idiom', idiom.toJson());
    return res;
  }
  Future saveList(List<Idiom> list)async{
    DataBaseHelper dataBaseHelper=DataBaseHelper();
    Database db=await dataBaseHelper.db;
    String sqlQuery='select * from idiom where word=?';

    list.forEach((idiom) async{
      var rawQuery = await db.rawQuery(sqlQuery,['${idiom.word}']);
      if(rawQuery!=null&&rawQuery.length>0){
        db.update('idiom', idiom.toJson());
      }else{
        await db.insert('idiom', idiom.toJson());
      }
    });

  }
  Future<List<Idiom>> queryBmob(int page)async{
    BmobQuery<Idiom> query = BmobQuery();
    query.setInclude('word');
    query.setLimit(200);
    if(page!=0){
      query.setSkip(page*200);
    }


    var queryObjects = await query.queryObjects();
    if(queryObjects!=null&&queryObjects.length>0){
      return queryObjects.map((map)=>Idiom.fromJson(map)).toList();
    }
  }

  Future<bool> isDbExist()async{
    Database db;
    try{
      String path=join(await getDatabasesPath(),'idiom.db');
      File file=File(path);
       db=await openDatabase(path);

       var v= await db.getVersion();
      return (await file.exists()&& v>0);
    }catch(e){
      return false;
    }finally{
    }

  }
  setDbVersion(int version)async{
    DataBaseHelper dataBaseHelper=DataBaseHelper();
    Database db=await dataBaseHelper.db;
    db.setVersion(version);
  }




}

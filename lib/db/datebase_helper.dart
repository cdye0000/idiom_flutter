import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataBaseHelper{
  static final DataBaseHelper _instance=  DataBaseHelper.internal();
  factory DataBaseHelper()=>_instance;
  DataBaseHelper.internal();
  static Database _db;

  Future<Database> get db async{
    if(_db!=null){
      return _db;
    }
    _db=await initDB();
    return _db;
  }


  initDB()async{
    String path=join(await getDatabasesPath(),'idiom.db');
    var db=await openDatabase(path,version: 1,onCreate: _onCreate,onUpgrade: _onUpgrade);
    return db;
  }
  void _onCreate(Database db,int version)async{
    String sql='create table idiom (id integer auto_increment,word text primary key,pinyin text,abbreviation text,explanation text,derivation text,example text,objectId text,createdAt text,updatedAt text，ACL text)';
    await db.execute(sql);


  }
  void _onUpgrade(Database db, int oldVersion, int newVersion)async{

  }

}
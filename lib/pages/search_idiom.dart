import 'package:flutter/material.dart';
import 'package:idiom_flutter/db/datebase_helper.dart';
import 'package:idiom_flutter/db/db_idiom.dart';
import 'package:idiom_flutter/pages/idiom_detail_page.dart';
import 'package:idiom_flutter/vo/idiomvo.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SearchPageState();
  }
}

class _SearchPageState extends State<SearchPage> {
  EasyRefreshController _controller;
  TextEditingController _textEditingController;
  int page=1;
  bool loading=false;
  String keywords;
  IdiomDBUtils _dbUtils;

  List<Idiom> _list = List();


  Future<List<Idiom>> _queryList({int pageNumber = 1, int pageSize = 15,String keywords=''}) async {
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
  Future _refresh()async{
    page=1;
    var list = await _queryList(keywords: keywords);
    setState(() {
      _list.clear();
      _list.addAll(list);
      page++;
    });
    _controller.resetLoadState();

  }
  Future _load()async{
    var list = await _queryList(keywords: keywords,pageNumber: page);
    setState(() {
      _list.addAll(list);
      page++;
    });
    _controller.finishLoad(noMore: list.length<15);

  }

  @override
  void initState() {
    super.initState();
    _dbUtils=IdiomDBUtils();
    _controller = EasyRefreshController();
    _textEditingController=TextEditingController();
    _textEditingController.addListener((){
      page=1;
      keywords=_textEditingController.text;
      _refresh();
    });
    _refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('搜索'),
          centerTitle: true,
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 20, right: 20,top: 10,bottom: 10),
                child: TextField(controller: _textEditingController,maxLength:4,decoration: InputDecoration.collapsed(hintText: '输入关键字'),),
              ),
              Expanded(
                  child: EasyRefresh(
                child: ListView.builder(
                  itemCount: _list == null ? 0 : _list.length,
                  itemBuilder: (context, index) =>
                      ListTile(title: Text('${_list[index].word}'),onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>IdiomDetailPage(idiom:_list[index])));

                      },),
                ),
                enableControlFinishRefresh: false,
                enableControlFinishLoad: true,
                controller: _controller,
                header: ClassicalHeader(),
                footer: ClassicalFooter(),
                    onRefresh:_refresh,
                    onLoad: _load,
              )),
            ],
          ),
        ));
  }
}

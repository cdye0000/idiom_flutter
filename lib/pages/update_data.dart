import 'package:flutter/material.dart';
import 'package:idiom_flutter/db/db_idiom.dart';
import 'package:idiom_flutter/widget/loading_dialog.dart';

class UpDateDataPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _UpDateDataState();
  }

}
class _UpDateDataState extends State<UpDateDataPage>{


  String tip='更新数据';
  _dismissDialog(){
    Navigator.of(context).pop();
  }

 static BuildContext _buildContext;
  IdiomDBUtils _idiomDBUtils;
  _syncData(int page)async {
//    showDialog(context: _buildContext,builder: (context)=>LoadingDialog(
//      dismissDialog: _dismissDialog(),
//    ));
//  setState(() {
//    tip='reading';
//  });
//  var queryBmob = await _idiomDBUtils.queryBmob(page);
//  if(queryBmob!=null&&queryBmob.length==200){
//    await _idiomDBUtils.saveList(queryBmob);
//    page++;
//    _syncData(page);
//  }else{
//    setState(() {
//      tip='complete';
//    });
//  }
  Navigator.pushNamed(context, 'file');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _idiomDBUtils=IdiomDBUtils();
  }

  @override
  Widget build(BuildContext context) {
    _buildContext=context;
    return Scaffold(
      appBar: AppBar(
        title: Text('检查数据'),
      ),
      body: Center(
        child: IndexedStack(
          index: 1,
          children: <Widget>[
            Text('$tip'),
            SizedBox(
              width: 200.0,
              height: 50.0,
              child: FlatButton(onPressed:(){
                _syncData(0);
              }, child: Text('$tip')),

            )
          ],

        ),

      ),
    );
  }

}
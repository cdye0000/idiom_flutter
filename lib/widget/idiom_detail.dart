import 'package:flutter/material.dart';
import 'package:idiom_flutter/vo/idiomvo.dart';

// ignore: must_be_immutable
class IdiomDetail extends StatelessWidget{
  Idiom _idiom;
  IdiomDetail(this._idiom):super();
  TextStyle titleStyle=TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );
  TextStyle wordStyle=TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 10),
          child: Text('${_idiom==null?'':_idiom.word}',style: wordStyle,),
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          child:  Text('拼音',style: titleStyle,),
        ),
        Text('${_idiom==null?'无':_idiom.pinyin}'),
        Container(
          margin: EdgeInsets.only(top: 10),
          child: Text('解释',style: titleStyle,),
        ),
        Text('${_idiom==null?'无':_idiom.explanation}'),
        Container(
          margin: EdgeInsets.only(top: 10),
          child:  Text('出处',style: titleStyle,),
        ),
        Text('${_idiom==null?'无':_idiom.derivation}'),
        Container(
          margin: EdgeInsets.only(top: 10),
          child:  Text('示例',style: titleStyle,),
        ),
        Text('${_idiom==null?'无':_idiom.example}'),
      ],
    );
  }



}

import 'dart:async';
import 'package:flutter/material.dart';
class LoadingDialog extends StatefulWidget{
  String loadingText;
  bool outsideDismiss;
  Function dismissDialog;
  LoadingDialog({
    Key key,
    this.loadingText='loading...',
    this.outsideDismiss=true,
    this.dismissDialog
}):super(key:key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoadingState();
  }

}

class _LoadingState extends State<LoadingDialog>{
  _dismissDialog(){
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.dismissDialog!=null){
      widget.dismissDialog((){
        Navigator.of(context).pop();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: widget.outsideDismiss ? _dismissDialog : null,
      child: Material(
        type: MaterialType.transparency,
        child: new Center(
          child: new SizedBox(
            width: 120.0,
            height: 120.0,
            child: new Container(
              decoration: ShapeDecoration(
                color: Color(0xffffffff),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
              ),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new CircularProgressIndicator(),
                  new Padding(
                    padding: const EdgeInsets.only(
                      top: 20.0,
                    ),
                    child: new Text(
                      widget.loadingText,
                      style: new TextStyle(fontSize: 12.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
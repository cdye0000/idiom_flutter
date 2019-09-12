import 'package:flutter/material.dart';
class StartPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _StartPageState();
  }


}

class _StartPageState extends State<StartPage>{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds:3 ),(){
      Navigator.of(context).pushReplacementNamed("home");

    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child:
          Image.asset('assets/images/start_page.jpeg',fit: BoxFit.cover,),

    );
  }
}
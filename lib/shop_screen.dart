import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'dashboard.dart';

class shop_screen extends StatefulWidget {
  const shop_screen({ Key? key }) : super(key: key);

  @override
  _shop_screenState createState() => _shop_screenState();
}

class _shop_screenState extends State<shop_screen> {

navigateToDashboard() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => dashboard()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget> [
          ElevatedButton(onPressed: navigateToDashboard
          , child: Text("Dashboard", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),))
        ],
      ),),
      
    );
  }
}
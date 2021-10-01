import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hopefully/add_product.dart';
import 'add_product.dart';

class dashboard extends StatefulWidget {


  @override
  _dashboardState createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {

navigateToAdd_product() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => add_product()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget> [
          ElevatedButton(onPressed: navigateToAdd_product
          , child: Text("Add Product", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),))
        ],
      ),),
    );
  }
}
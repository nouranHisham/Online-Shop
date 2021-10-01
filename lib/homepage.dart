import 'package:hopefully/shop_screen.dart';

import 'start.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'shop_screen.dart';
// import 'package:authentification/Start.dart';

class homepage extends StatefulWidget {
  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;
  bool isloggedin = false;

  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => start()));
      }
    });
  }

  getUser() async {
    User? firebaseUser = _auth.currentUser;
    await firebaseUser?.reload();
    firebaseUser = _auth.currentUser;

    if (firebaseUser != null) {
      setState(() {
        this.user = firebaseUser;
        this.isloggedin = true;
      });
    }
  }

  signOut() async {
    _auth.signOut();
  }

  navigateToShop_screen() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => shop_screen()));
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentification();
    this.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Container(
      child: !isloggedin
            ? CircularProgressIndicator()
            : Column( mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Text(
                      "Hello, ${user!.displayName} you are Logged in as ${user!.email}",
                      style:
                          TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ElevatedButton.icon(onPressed: navigateToShop_screen,
                   label: Text("Start Shopping",
                  style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold))
                  , icon: Icon(
            Icons.arrow_forward,
            color: Colors.white,
            size: 15,
          ),
         ),
                  ElevatedButton(
                     onPressed: signOut,
                      child: Text('Signout',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold))),
                ],
              ),
    ),
        ));
  }
}

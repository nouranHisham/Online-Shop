// ignore_for_file: unused_field

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'dashboard.dart';

class add_product extends StatefulWidget {
  @override
  _add_productState createState() => _add_productState();
}

class _add_productState extends State<add_product> {
  TextEditingController _name = new TextEditingController();
  TextEditingController _description = new TextEditingController();
  TextEditingController _category = new TextEditingController();

  CollectionReference products =
      FirebaseFirestore.instance.collection("products");

  File? _image;
  var _url;
  String? fileName;
  final picker = ImagePicker();

  Future pickImages() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile!.path);
    });
  }

   _uploadImages(BuildContext context) async {
    fileName = basename(_image!.path);
    Reference firebaseStorage =
        FirebaseStorage.instance.ref().child('uploads/$fileName');
    UploadTask uploadTask = firebaseStorage.putFile(_image!);
    TaskSnapshot taskSnapshot = await uploadTask;
    taskSnapshot.ref.getDownloadURL().then((value) => print("Done: $value"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: _image != null
                  ? Image.file(_image!)
                  : TextButton(
                      onPressed: pickImages,
                      child: Icon(
                        Icons.add_a_photo,
                        size: 50,
                      )),
            ),
            ElevatedButton(
                onPressed: () => _uploadImages(context),
                child: Text(
                  "Upload Image",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                )),
            TextFormField(
              controller: _name,
              decoration: InputDecoration(hintText: "Name"),
            ),
            TextFormField(
              controller: _description,
              decoration: InputDecoration(hintText: "Description"),
            ),
            TextFormField(
              controller: _category,
              decoration: InputDecoration(hintText: "Category"),
            ),
            ElevatedButton(
                onPressed: () async {
                  Map<String, dynamic> data = {
                    "name": _name.text,
                    "description": _description.text,
                    "category": _category.text,
                    "imagURL": _url,
                  };
                  await products.add(data);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => dashboard()));
                },
                child: Text(
                  "Add",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ))
          ],
        ),
      ),
    ));
  }
}

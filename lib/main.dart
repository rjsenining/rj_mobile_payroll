import 'package:flutter/material.dart';
import 'package:mobile_appdev_integrated/views/auth/login_page.dart';



void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primarySwatch: Colors.lightBlue),
    home: LoginPage(),
  ));
}




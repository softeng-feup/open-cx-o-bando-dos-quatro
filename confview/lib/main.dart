import 'package:flutter/material.dart';
import 'home.dart';

void main() => runApp(ConfView());

class ConfView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: 'Conference Viewer',

      theme: ThemeData(
        primarySwatch: Colors.blue,

      ),

      home: HomePage(title: 'Conference Viewer'),

    );
  }
}


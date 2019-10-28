import 'package:flutter/material.dart';
//import 'home.dart';
import 'nav.dart';

void main() => runApp(ConfView());

class ConfView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: 'Conference Viewer',

      theme: ThemeData(
        primarySwatch: Colors.blue,

      ),

      home: MapScreen(conferenceId: 0),
      //home: HomePage(title: 'Conference Viewer'),

    );
  }
}


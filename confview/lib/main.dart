import 'package:flutter/material.dart';

import 'home.dart';
import 'panorama_view.dart';
import 'conference.dart';

/*
TODO: FIXME:
  This is a very important note!!
  When first compiling to IOS the app must be Swift based and the Podfile must be modified
  to contain the following two lines of code at the top of the file

    platform : ios, '8.0'
    use_frameworks!

  For more information take a look at this link : https://pub.dev/packages/flutter_nfc_reader

  Android setup is already completed.
*/


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
      //home: MapScreen(conferenceId: 0),
      //home: Conference(),

    );
  }
}


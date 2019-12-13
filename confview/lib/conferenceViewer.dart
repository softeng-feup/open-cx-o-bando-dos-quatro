import 'dart:math';

import 'package:confview/panorama_view.dart';
import 'package:flutter/material.dart';

import 'package:confview/map_data.dart';


class ConferenceViewer extends StatefulWidget {
  final List<Node> locations;
  int startIndex = 0;
  ConferenceViewer({Key key, this.locations,this.startIndex}) : super(key: key);

  @override
  _ConferenceViewerState createState() => _ConferenceViewerState();
}

class _ConferenceViewerState extends State<ConferenceViewer> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("f");
    return PanoramaView(
        locations: this.widget.locations, location: this.widget.locations[this.widget.startIndex]);
  }
}

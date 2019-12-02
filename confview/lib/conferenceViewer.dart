import 'dart:math';

import 'package:confview/panorama_view.dart';
import 'package:flutter/material.dart';

class PanoramaViewImage {
  String imageUrl;
  NetworkImage networkImage;
  double width;
  double height;
  bool loaded;

  PanoramaViewImage(this.imageUrl) {
    this.networkImage = null;
    this.width = null;
    this.height = null;
    this.loaded = false;
  }
}

class Location {
  final String name;
  PanoramaViewImage image;
  List<Tag> tags = new List<Tag>();

  double x; //X coord of location on the map
  double y; //Y coord of location on the map

  bool visited = false;
  double distance = double.maxFinite;
  String path = "";

  Location(this.name, this.image, this.x, this.y);

  void addTag(Tag t) {
    tags.add(t);
  }

  void addTag2(Location dest, double x, double y) {
    tags.add(new Tag(this, dest));
  }

  List<Tag> getTags() {
    return this.tags;
  }

  String getName() {
    return this.name;
  }

  double getX() {
    return this.x;
  }

  double getY() {
    return this.y;
  }

  Offset getOffset() {
    return Offset(this.x, this.x);
  }

  /*void tagsLocationReferences(List<Location> locs) {
    for (int i = 0; i < this.tags.length; i++)
      this.tags[i].getLocationReference(locs);
  }*/
}


class Edge{
  String origin;
  String dest;
  Edge(this.origin,this.dest);
  String getOrigin(){
    return this.origin;
  }
  String getDest(){
    return this.dest;
  }
}

class Tag {

  Location origin;
  Location dest;
  double x; //X on the image
  double y; //Y on the image
  Tag(this.origin,this.dest){

    //TODO:: Find a way to calculate alignement
    double vx = this.dest.getX() - this.origin.getX();
    double vy = this.dest.getY() - this.origin.getY();

    double ang = atan(vy/vx);
    if(vx < 0) ang += pi;


    this.x =  -ang/(2*pi);
    this.y = 0;
  }

  Alignment getAlignment() {
    return Alignment(x, y);
  }

  String getText() {
    return dest.getName();
  }
/*
  void getLocationReference(List<Location> locations) {
    for (int i = 0; i < locations.length; i++) {
      if (locations[i].getName() == this.text) {
        this.location = locations[i];
        break;
      }
    }
  }*/
}

class ConferenceViewer extends StatefulWidget {
  List<Location> locations;

  ConferenceViewer({Key key, this.locations}) : super(key: key);

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
    return PanoramaView(
        locations: this.widget.locations, location: this.widget.locations[0]);
  }
}

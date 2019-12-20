import 'dart:math';

import 'package:flutter/material.dart';

class Node {
  final int _id;
  Offset _position;
  List<Edge> _edges = new List<Edge>();

  final String name;
  PanoramaViewImage image;

  bool visited = false;
  double distance = double.maxFinite;
  String path = "";

  bool selected = false;

  Node(this._id, this.name, String imageUrl, double x, double y) {
    image = new PanoramaViewImage(imageUrl);
    _position = Offset(x, -y);
  }

  int getID() {
    return _id;
  }

  Offset getPosition() {
    return _position;
  }

  bool addEdge(Edge edge) {
    if (edge.getSrcNode() != this ||
        edge.getDestNode() == null ||
        edge.getSrcNode() == null) {
      return false;
    }
    _edges.add(edge);
    return true;
  }

  void updatePosition(Offset offset) {
    this._position += offset;
  }

  String getName() {
    return this.name;
  }

  double getX() {
    return this._position.dx;
  }

  double getY() {
    return this._position.dy;
  }

  List<Edge> getEdges() {
    return _edges;
  }
}

class Edge {
  final Node _src, _dest;
  double _distance;

  double x; //X on the image
  double y; //Y on the image

  Edge(this._src, this._dest) {
    if (this._src == null) throw Exception('Source can not be null');
    if (this._dest == null) throw Exception('Destination can not be null');
    calculateAlign();

    //print(_src.getName() + " -> " + _dest.getName() + "  " +  this.x.toString() + "  " + this.y.toString());
  }

  void calculateAlign() {
    _distance = sqrt(pow(_src.getPosition().dx - _dest.getPosition().dx, 2) +
        pow(_src.getPosition().dy - _dest.getPosition().dy, 2));

    //TODO:: Find a way to calculate alignement
    double vx = this._dest.getX() - this._src.getX();
    double vy = this._dest.getY() - this._src.getY();

    double ang = atan(vy / vx);
    if (vx < 0) ang += pi;
    this.x = -ang /
        (2 * pi) *
        4; //TODO:: Carefull with this value it was hardoded and it is not to be here
    this.y = 0;
  }

  Node getSrcNode() {
    return _src;
  }

  Node getDestNode() {
    return _dest;
  }

  double getDistance() {
    return _distance;
  }

  String getScrName() {
    return _src.getName();
  }

  String getDestName() {
    return _dest.getName();
  }

  Alignment getAlignment() {
    return Alignment(x, y);
  }
}

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

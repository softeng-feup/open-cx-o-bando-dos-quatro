import 'dart:math';
import 'package:flutter/material.dart';

class Node {
  final int _id;
  Offset _position;
  List<Edge> _edges = [];

  Node(this._id, double x, double y) {
    _position = Offset(x, y);
  }

  int getID() {
    return _id;
  }
  Offset getPosition() {
    return _position;
  }

  bool addEdge(Edge edge) {
    if (edge.getSrcNode() != this) {
      return false;
    }
    _edges.add(edge);
    return true;
  }

  void updatePosition(Offset offset) {
    this._position += offset;
  }
}

class Edge {
  final Node _src, _dest;
  double _distance;

  Edge(this._src, this._dest) {

    _distance = sqrt(pow(_src.getPosition().dx- _dest.getPosition().dx, 2) + pow(_src.getPosition().dy - _dest.getPosition().dy, 2));
  }

  Node getSrcNode() { return _src; }
  Node getDestNode() { return _dest; }
  double getDistance() { return _distance; }
}
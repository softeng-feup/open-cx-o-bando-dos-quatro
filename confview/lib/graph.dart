import 'package:flutter/material.dart';

import 'map_data.dart';

class Graph {
  List<Node> _nodes = [];
  List<Edge> _edges = [];

  Graph();

  bool addNode(Node node) {
    //print("add");
    //print(node);
    if (null != getNode(node.getID())) {
      return false;
    }

    _nodes.add(node);
    return true;
  }

  Node getNode(int nodeID) {
    for (Node node in _nodes) {
      if (node.getID() == nodeID) return node;
    }
    return null;
  }

  List<Node> getNodes() {
    return _nodes;
  }

  bool addEdge(int srcID, int destID) {
    Node srcNode = getNode(srcID);
    Node destNode = getNode(destID);

    if (srcNode == null || destNode == null) return false;

    Edge edge = new Edge(srcNode, destNode);
    if (!srcNode.addEdge(edge)) return false;
    _edges.add(edge);

    Edge bidirectionalEdge = new Edge(destNode, srcNode);
    if (!destNode.addEdge(bidirectionalEdge)) return false;
    _edges.add(bidirectionalEdge);

    return true;
  }

  List<Edge> getEdges() {
    return _edges;
  }

  void updatePositions(Offset offset) {
    for (Node node in _nodes) {
      node.updatePosition(offset);
    }
  }
}

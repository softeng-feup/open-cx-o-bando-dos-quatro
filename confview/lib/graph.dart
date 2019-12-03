import 'dart:math';
import 'package:flutter/material.dart';


class Graph {

    List<Node> _nodes = [];
    List<Edge> _edges = [];

    Graph();


    void addNode(Node node) {
        print(node);
        _nodes.add(node);
    }

    Node getNode(int nodeID) {
        for (Node node in _nodes) {
            if (node.getID() == nodeID)
                return node;
        }
        return null;
    }

    List<Node> getNodes() {
        return _nodes;
    }

    bool addEdge(int srcID, int destID) {
        Node srcNode = getNode(srcID);
        Node destNode = getNode(destID);
        // TODO: do error checking in case there is no node with the specified ids

        Edge edge = new Edge(srcNode, destNode);
        if (!srcNode.addEdge(edge))
            return false;
        _edges.add(edge);
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
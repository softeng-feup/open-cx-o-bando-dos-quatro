
import 'package:flutter/material.dart';

import 'map_data.dart';


class Graph {

    List<Node> _nodes = [];
    List<Edge> _edges = [];

    Graph();


    void addNode(Node node) {
        //print("add");
        //print(node);
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


        Edge bidirectionalEdge = new Edge(destNode, srcNode);
        if (!destNode.addEdge(bidirectionalEdge))
            return false;
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


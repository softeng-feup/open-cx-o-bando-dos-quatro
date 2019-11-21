import 'dart:math';

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
}

class Node {
    final int _id;
    final double _x;
    final double _y;
    List<Edge> _edges = [];

    Node(this._id, this._x, this._y);

    int getID() { return _id; }
    double getX() { return _x; }
    double getY() { return _y; }

    bool addEdge(Edge edge) {
        if (edge.getSrcNode() != this) {
            return false;
        }
        _edges.add(edge);
        return true;
    }
}

class Edge {
    final Node _src, _dest;
    double _distance;

    Edge(this._src, this._dest) {
        _distance = sqrt(pow(_src.getX() - _dest.getX(), 2) + pow(_src.getY() - _dest.getY(), 2));
    }

    Node getSrcNode() { return _src; }
    Node getDestNode() { return _dest; }
    double getDistance() { return _distance; }
}
import 'dart:math';

import 'package:flutter/material.dart';
import 'graph.dart';
import 'map_data.dart';


class GraphDraw extends StatefulWidget {

    GraphDraw ({Key key}) : super(key: key);

    @override
    _GraphDrawState createState() => _GraphDrawState();
}

class _GraphDrawState extends State<GraphDraw> {

    Graph _graph = new Graph();
    bool _addScreenOffset = true;
    
    @override
    void initState() {
        super.initState();
        _buildGraph();
    }

    // TODO: this is a testing function to build a graph
    void _buildGraph() {
        _graph.addNode(Node(1, 0, 0));
        _graph.addNode(Node(2, 90, 45));
        _graph.addNode(Node(3, 180, 0));
        _graph.addNode(Node(4, 90, 90));

        _graph.addEdge(1, 2);
        _graph.addEdge(1, 3);
    }
    // offset in pixels
    Offset _graphHorizontalOffset = Offset(0.0, 0.0);
    Offset _graphVerticalOffset = Offset(0.0, 0.0);
    Offset _graphOffset = Offset(0.0, 0.0);

    @override 
    Widget build(BuildContext context) {
        
        if (_addScreenOffset) { 
            _graphOffset += Offset(MediaQuery.of(context).size.width / 2.0, MediaQuery.of(context).size.height / 2.0 - kToolbarHeight);
            _addScreenOffset = false;
        }

        return Container(
            child: CustomPaint(
            painter: GraphPainter(context, _graph, _graphOffset),
            child: GestureDetector(
                onVerticalDragStart: (details) {
                    _graphVerticalOffset = details.globalPosition; 
                },
                onVerticalDragUpdate: (details) {
                    _graphOffset += details.globalPosition - _graphVerticalOffset;
                    _graphVerticalOffset = details.globalPosition;
                    setState(() {});
                    print('graph offset : ' + _graphOffset.toString());
                },
                onHorizontalDragStart: (details) {
                    _graphHorizontalOffset = details.globalPosition;
                },
                onHorizontalDragUpdate: (details) {
                    _graphOffset += details.globalPosition - _graphHorizontalOffset;
                    _graphHorizontalOffset = details.globalPosition;
                    setState(() {});
                    print('graph offset : ' + _graphOffset.toString());
                },
                onTapDown: _tap,
                ),
            )
        );
    }

    void _tap(TapDownDetails details) {

        Offset tap = details.localPosition;

        for (Node node in _graph.getNodes()) {
            Offset nodeOffset = node.getPosition() + _graphOffset;
            double distance = sqrt(pow(tap.dx - nodeOffset.dx, 2) + pow(tap.dy - nodeOffset.dy, 2));

            if (distance <= 17) {
                print("pressed node with id : " + node.getID().toString());
                break;
            }
        }
    }
}

class GraphPainter extends CustomPainter {

    final Graph _graph;
    final BuildContext _context;
    final Offset _offset;
    Offset _screenOffset;   
    

    GraphPainter(this._context, this._graph, this._offset) {
        Size size = MediaQuery.of(_context).size;
        _screenOffset = Offset(size.width / 2.0, size.height / 2.0 - kToolbarHeight);
    }

    @override
    void paint(Canvas canvas, Size size) {
        print('inside paint');
        final paintNormalEdge = Paint()
            ..strokeWidth = 5;
        paintNormalEdge.color = Colors.black;

        final paintNormalNode = Paint();
        paintNormalNode.color = Colors.orangeAccent;

        for (Edge edge in _graph.getEdges()) {
            Node srcNode = edge.getSrcNode();
            Node destNode = edge.getDestNode();

            Offset srcOffset = srcNode.getPosition() /*+ _screenOffset*/ + _offset;
            Offset destOffset = destNode.getPosition() /*+ _screenOffset*/ + _offset;

            canvas.drawLine(srcOffset, destOffset, paintNormalEdge);
        }

        for (Node node in _graph.getNodes()) {
            Offset nodeOffset = node.getPosition() + /*_screenOffset +*/ _offset;
            canvas.drawCircle(nodeOffset, 15, paintNormalNode);
        }
    }

    @override
    bool shouldRepaint(GraphPainter oldDelegate) {
        return oldDelegate._offset != _offset;
    }
}

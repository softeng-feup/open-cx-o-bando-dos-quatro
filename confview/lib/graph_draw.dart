import 'package:flutter/material.dart';
import 'graph.dart';
import 'dart:math';

class GraphDraw extends StatefulWidget {

    GraphDraw ({Key key}) : super(key: key);

    @override
    _GraphDrawState createState() => _GraphDrawState();
}

class _GraphDrawState extends State<GraphDraw> {

    Graph _graph = new Graph();
    
    @override
    void initState() {
        super.initState();
        _buildGraph();
    }

    // TODO: this is a testing function to build a graph
    void _buildGraph() {
        _graph.addNode(Node(1, 0.0, 0.0));
        _graph.addNode(Node(2, 1.0, 0.5));
        _graph.addNode(Node(3, 2.0, 0.0));
        _graph.addNode(Node(4, 1.0, 1.0));

        _graph.addEdge(1, 2);
        _graph.addEdge(1, 3);
    }
    

    final double _dragResistance = 200.0; 
    Alignment _graphAlignment = Alignment(0.0, 0.0); 

    @override 
    Widget build(BuildContext context) {
        List<Widget> stack = [];

        stack.add(_buildEdges());

        List<Node> nodes = _graph.getNodes();

        for (Node node in nodes) {
            stack.add(
                Container(
                    alignment: Alignment(node.getX(), node.getY()) + _graphAlignment,
                    child: _buildNode(node),
                ),
            );
        }

        stack.add(
            GestureDetector(
                onHorizontalDragUpdate: _dragGraph,
                onVerticalDragUpdate: _dragGraph,
            )
        );
        
        return Stack(
            children: stack,
        );
        
    }

    _dragGraph(DragUpdateDetails details) {
        double dx = _graphAlignment.x + details.delta.dx / _dragResistance;
        double dy = _graphAlignment.y + details.delta.dy / _dragResistance;

        setState(() {
            _graphAlignment = Alignment(dx, dy); 
        });

        print(_graphAlignment);
    }

    Widget _buildNode(Node node) {

        return RawMaterialButton(
            shape: CircleBorder(),
            child: Text(node.getID().toString()),
            elevation: 2.0,
            fillColor: Colors.red,
            autofocus: false,
            padding: const EdgeInsets.all(15.0),
            onPressed: (){
                print('Pressed Node');
            },
        );
    }

    Widget _buildEdges() {
        return CustomPaint(
            painter: EdgePainter(MediaQuery.of(context).size, _graphAlignment, _graph.getEdges()),
            child: Text('change this'),
        );
    }
}


class EdgePainter extends CustomPainter {

    final Size _screenSize;
    final Alignment _alignment;
    final List<Edge> _edges;

    EdgePainter (this._screenSize, this._alignment, this._edges);

    @override 
    void paint(Canvas canvas, Size size) {
        final paint = Paint();
        paint.color = Colors.black;

        for (Edge edge in _edges) {
            Node src = edge.getSrcNode();
            Node dest = edge.getDestNode();

            double srcX = (src.getX() + _alignment.x) * _screenSize.width / 2.0 + _screenSize.width / 2.0;
            double srcY = (src.getY() + _alignment.y) * _screenSize.height / 2.0 + _screenSize.height / 2.0 - kToolbarHeight;

            double destX = (dest.getX() + _alignment.x) * _screenSize.width / 2.0 + _screenSize.width / 2.0;
            double destY = (dest.getY() + _alignment.y) * _screenSize.height / 2.0 + _screenSize.height / 2.0 - kToolbarHeight;

            Offset srcOffset = Offset(srcX, srcY);
            Offset destOffset = Offset(destX, destY);

            canvas.drawLine(srcOffset, destOffset, paint);
        }
    }


    @override 
    bool shouldRepaint(CustomPainter oldDelegate) {
        return true;
    }
}
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'graph.dart';
import 'map_data.dart';

import 'conferenceViewer.dart';


class GraphDraw extends StatefulWidget {

    GraphDraw ({Key key , this.graph}) : super(key: key);

    final Graph graph;

    @override
    _GraphDrawState createState() => _GraphDrawState();
}

class _GraphDrawState extends State<GraphDraw> {

    //Graph _graph = new Graph();
    bool _addScreenOffset = true;
    
    @override
    void initState() {
        super.initState();
        //_buildGraph();
    }

    // TODO: this is a testing function to build a graph
    /*void _buildGraph() {
        _graph.addNode(Node(1, 0, 0));
        _graph.addNode(Node(2, 90, 45));
        _graph.addNode(Node(3, 180, 0));
        _graph.addNode(Node(4, 90, 90));

        _graph.addEdge(1, 2);
        _graph.addEdge(1, 3);
    }*/
    // offset in pixels
    Offset _graphHorizontalOffset = Offset(0.0, 0.0);
    Offset _graphVerticalOffset = Offset(0.0, 0.0);
    Offset _graphOffset = Offset(0.0, 0.0);
    double _scale = 1;

    @override 
    Widget build(BuildContext context) {
        
        if (_addScreenOffset) { 
            _graphOffset += Offset(MediaQuery.of(context).size.width / 2.0, MediaQuery.of(context).size.height / 2.0 - kToolbarHeight);
            _addScreenOffset = false;
        }

        return Stack(
                children: [


                    Container(
                    child: CustomPaint(
                    painter: GraphPainter(context, widget.graph, _graphOffset, _scale),
                    child: GestureDetector(
                        onVerticalDragStart: (details) {
                            _graphVerticalOffset = details.globalPosition;
                        },
                        onVerticalDragUpdate: (details) {
                            Offset tempOffset = details.globalPosition - _graphVerticalOffset;
                            _graphOffset += Offset(tempOffset.dx / _scale , tempOffset.dy/_scale);

                            _graphVerticalOffset = details.globalPosition;
                            setState(() {});
                            //print('graph offset : ' + _graphOffset.toString());
                        },
                        onHorizontalDragStart: (details) {
                            _graphHorizontalOffset = details.globalPosition;
                        },
                        onHorizontalDragUpdate: (details) {
                            Offset tempOffset = details.globalPosition - _graphHorizontalOffset;
                            _graphOffset += Offset(tempOffset.dx / _scale , tempOffset.dy/_scale);

                            _graphHorizontalOffset = details.globalPosition;
                            setState(() {});
                            //print('graph offset : ' + _graphOffset.toString());
                        },
                        onTapDown: _tap,

                        ),

                    )
                ),
                    Column(
                        children: <Widget>[
                            IconButton(
                                icon: Icon(Icons.add),
                                color: Colors.blue,
                                tooltip: 'Zoom in',
                                onPressed: (){
                                    _scale*=1.5;
                                    setState(() {});
                                }
                            ),

                            IconButton(
                                icon: Icon(Icons.remove),
                                color: Colors.blue,
                                tooltip: 'Zoom out',
                                onPressed: (){
                                    _scale/=1.5;
                                    setState(() {});
                                }
                            ),
                        ]
                    ),
                ]
        );
    }

    void _tap(TapDownDetails details) {

        Size size = MediaQuery.of(context).size;
        Offset _screenOffset = Offset(size.width / 2.0, size.height / 2.0 - kToolbarHeight);


        Offset tap = details.localPosition;

        for (Node node in widget.graph.getNodes()) {
            Offset nodeOffset = node.getPosition() - _screenOffset + _graphOffset;
            nodeOffset *= _scale;
            nodeOffset += _screenOffset;
            double distance = sqrt(pow(tap.dx - nodeOffset.dx, 2) + pow(tap.dy - nodeOffset.dy, 2));

            if (distance <= 17) {
                print("pressed node with id : " + node.getID().toString());
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ConferenceViewer(
                        locations: widget.graph.getNodes(), startIndex: node.getID(),
                    )));
                break;
            }
        }
    }
}

class GraphPainter extends CustomPainter {

    final Graph _graph;
    final BuildContext _context;
    final Offset _offset;
    final double _scale;
    Offset _screenOffset;   
    

    GraphPainter(this._context, this._graph, this._offset,this._scale) {
        Size size = MediaQuery.of(_context).size;
        _screenOffset = Offset(size.width / 2.0, size.height / 2.0 - kToolbarHeight);
        //print(_screenOffset);
    }

    @override
    void paint(Canvas canvas, Size size) {
        //print('inside paint');
        final paintNormalEdge = Paint()
            ..strokeWidth = 5;
        paintNormalEdge.color = Colors.black;

        final paintNormalNode = Paint();
        paintNormalNode.color = Colors.orangeAccent;

        for (Edge edge in _graph.getEdges()) {
            Node srcNode = edge.getSrcNode();
            Node destNode = edge.getDestNode();

            Offset srcOffset = srcNode.getPosition() - _screenOffset + _offset;
            Offset destOffset = destNode.getPosition() - _screenOffset + _offset;
            srcOffset *= _scale;
            destOffset *= _scale;
            srcOffset += _screenOffset;
            destOffset += _screenOffset;


            canvas.drawLine(srcOffset, destOffset, paintNormalEdge);
        }

        for (Node node in _graph.getNodes()) {
            Offset nodeOffset = node.getPosition() - _screenOffset + _offset;
            nodeOffset *= _scale;
            nodeOffset += _screenOffset;
            canvas.drawCircle(nodeOffset, 15, paintNormalNode);
        }
        for (Node node in _graph.getNodes()) {

            double fontSize = 15;

            ui.TextStyle textStyle = ui.TextStyle(
                color: Colors.lightBlue,
                fontSize: fontSize,
            );
            Offset nodeOffset = node.getPosition() - _screenOffset + _offset;
            nodeOffset *= _scale;
            nodeOffset += _screenOffset;

            ui.ParagraphStyle style = ui.ParagraphStyle(textDirection: TextDirection.ltr);
            ui.ParagraphBuilder paragBuilder = ui.ParagraphBuilder(style)
                ..pushStyle(textStyle)
                ..addText(node.getName());
            ui.ParagraphConstraints constraints = ui.ParagraphConstraints(width: 300);
            ui.Paragraph text = paragBuilder.build();
            text.layout(constraints);

            canvas.drawParagraph(text, nodeOffset - Offset(node.getName().length/4 * fontSize,30));
        }
    }

    @override
    bool shouldRepaint(GraphPainter oldDelegate) {
        return oldDelegate._offset != _offset;
    }
}

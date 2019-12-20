import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'conferenceViewer.dart';
import 'graph.dart';
import 'map_data.dart';

class GraphDraw extends StatefulWidget {
  GraphDraw({Key key, this.graph, this.conferenceId}) : super(key: key) {
    print('asfg');
  }

  final Graph graph;
  final int conferenceId;

  @override
  _GraphDrawState createState() => _GraphDrawState();
}

class _GraphDrawState extends State<GraphDraw> {
  //Graph _graph = new Graph();
  static bool _addScreenOffset = true;

  static ui.Image backgroundImage;

  static int currentConference = -1;
  int conferenceId;

  static Offset _graphHorizontalOffset;
  static Offset _graphVerticalOffset;
  static Offset _graphOffset;
  static double _scale;

  @override
  void initState() {
    super.initState();
    print(currentConference);
    if (this.widget.conferenceId == currentConference) {
      return;
    } else {
      currentConference = this.widget.conferenceId;
    }
    _addScreenOffset = true;
    _graphHorizontalOffset = Offset(0.0, 0.0);
    _graphVerticalOffset = Offset(0.0, 0.0);
    _graphOffset = Offset(0.0, 0.0);
    _scale = 1;

//        Image tempImage = Image.network("http://www.loc.gov/static/portals/visit/maps-and-floor-plans/images/campus-map.jpg");
    //Uri uri = Uri.dataFromString("http://www.loc.gov:anonious/static/portals/visit/maps-and-floor-plans/images/");
    //http://fcrevit.org/merrifield/images/MosaicMap022516.png
    backgroundImage = null;
    _getImage();
  }

  _getImage() {
    backgroundImage = null;
    try {
      Uri uri = Uri.http("fcrevit.org", "/merrifield/images/");
      NetworkAssetBundle(uri).load("MosaicMap022516.png").then((bd) {
        Uint8List lst = new Uint8List.view(bd.buffer);

        ui.instantiateImageCodec(lst).then((codec) {
          codec.getNextFrame().then((frameInfo) {
            setState(() {
              //backgroundImage = frameInfo.image;
            });
            //backgroundImage = null;
            print("bkImage instantiated: $backgroundImage");
          });
        });
      }).catchError((e) {
        print(e);
        backgroundImage = null;
      });
    } on Exception catch (e) {
      print(e);
      backgroundImage = null;
    } finally {
      if (mounted) setState(() {});
    }
  }

  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_addScreenOffset) {
      _graphOffset += Offset(MediaQuery.of(context).size.width / 2.0,
          MediaQuery.of(context).size.height / 2.0 - kToolbarHeight);
      _addScreenOffset = false;
    }

    return Stack(children: [
      Container(
          child: CustomPaint(
        painter: GraphPainter(
            context, backgroundImage, widget.graph, _graphOffset, _scale),
        child: GestureDetector(
          onVerticalDragStart: (details) {
            _graphVerticalOffset = details.globalPosition;
          },
          onVerticalDragUpdate: (details) {
            Offset tempOffset = details.globalPosition - _graphVerticalOffset;
            _graphOffset +=
                Offset(tempOffset.dx / _scale, tempOffset.dy / _scale);

            _graphVerticalOffset = details.globalPosition;
            setState(() {});
            //print('graph offset : ' + _graphOffset.toString());
          },
          onHorizontalDragStart: (details) {
            _graphHorizontalOffset = details.globalPosition;
          },
          onHorizontalDragUpdate: (details) {
            Offset tempOffset = details.globalPosition - _graphHorizontalOffset;
            _graphOffset +=
                Offset(tempOffset.dx / _scale, tempOffset.dy / _scale);

            _graphHorizontalOffset = details.globalPosition;
            setState(() {});
            //print('graph offset : ' + _graphOffset.toString());
          },
          onTapDown: _tap,
        ),
      )),
      Column(children: <Widget>[
        IconButton(
            icon: Icon(Icons.add),
            color: Colors.blue,
            tooltip: 'Zoom in',
            onPressed: () {
              _scale *= 1.5;
              setState(() {});
            }),
        IconButton(
            icon: Icon(Icons.remove),
            color: Colors.blue,
            tooltip: 'Zoom out',
            onPressed: () {
              _scale /= 1.5;
              setState(() {});
            }),
      ]),
    ]);
  }

  void _tap(TapDownDetails details) {
    Size size = MediaQuery.of(context).size;
    Offset _screenOffset =
        Offset(size.width / 2.0, size.height / 2.0 - kToolbarHeight);

    Offset tap = details.localPosition;
    int i = 0;
    for (Node node in widget.graph.getNodes()) {
      Offset nodeOffset = node.getPosition() - _screenOffset + _graphOffset;
      nodeOffset *= _scale;
      nodeOffset += _screenOffset;
      double distance =
          sqrt(pow(tap.dx - nodeOffset.dx, 2) + pow(tap.dy - nodeOffset.dy, 2));

      if (distance <= 17) {
        print("pressed node with id : " + node.getID().toString());
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ConferenceViewer(
                  locations: widget.graph.getNodes(),
                  startIndex: i,
                )));
        break;
      }
      i++;
    }
  }
}

class GraphPainter extends CustomPainter {
  final Graph _graph;
  final BuildContext _context;
  final Offset _offset;
  final double _scale;
  Offset _screenOffset;
  final ui.Image backgroundImage;

  GraphPainter(this._context, this.backgroundImage, this._graph, this._offset,
      this._scale) {
    Size size = MediaQuery.of(_context).size;
    _screenOffset =
        Offset(size.width / 2.0, size.height / 2.0 - kToolbarHeight);
    //print(_screenOffset);
  }

  @override
  void paint(Canvas canvas, Size size) {
    //print('inside paint');
    final paintNormalEdge = Paint()..strokeWidth = 5;
    paintNormalEdge.color = Colors.black;

    final paintNormalNode = Paint();
    paintNormalNode.color = Colors.orangeAccent;
    final paintSelectedNode = Paint();
    paintSelectedNode.color = Colors.redAccent;
    if (backgroundImage != null) {
      double bkwidth = backgroundImage.width.toDouble();
      double bkheight = backgroundImage.height.toDouble();
      canvas.drawImageRect(
          backgroundImage,
          (const Offset(0, 0) & Size(bkwidth, bkheight)),
          (_offset - _screenOffset - _screenOffset) * _scale + _screenOffset &
              Size(bkwidth * _scale, bkheight * _scale),
          new Paint());
      //canvas.drawImage(backgroundImage, _offset - _screenOffset, new Paint());
    }
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
      if (node.selected)
        canvas.drawCircle(nodeOffset, 5 + 10 * (_scale), paintSelectedNode);
      else
        canvas.drawCircle(nodeOffset, 5 + 10 * (_scale), paintNormalNode);
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

      ui.ParagraphStyle style =
          ui.ParagraphStyle(textDirection: TextDirection.ltr);
      ui.ParagraphBuilder paragBuilder = ui.ParagraphBuilder(style)
        ..pushStyle(textStyle)
        ..addText(node.getName());
      ui.ParagraphConstraints constraints = ui.ParagraphConstraints(width: 300);
      ui.Paragraph text = paragBuilder.build();
      text.layout(constraints);

      canvas.drawParagraph(
          text, nodeOffset - Offset(node.getName().length / 4 * fontSize, 30));
    }
  }

  @override
  bool shouldRepaint(GraphPainter oldDelegate) {
    return oldDelegate._offset != _offset;
  }
}

import 'package:flutter/material.dart';

class GraphDraw extends StatefulWidget {

    GraphDraw ({Key key}) : super(key: key);

    @override
    _GraphDrawState createState() => _GraphDrawState();
}

class _GraphDrawState extends State<GraphDraw> {

    List<List<double>> _points = [[0,0], [1,0.5], [2, 0]];

    final double dragResistance = 200.0; 
    Alignment _graphAlignment = Alignment.center;
    

    @override 
    Widget build(BuildContext context) {

        List<Widget> stack = [];

        for (var node in _points) {
            stack.add(
                Container(
                    alignment: Alignment(node[0], node[1]) + _graphAlignment,
                    child: _buildNode(),
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
        double dx = _graphAlignment.x + details.delta.dx / dragResistance;
        print(dx);
        double dy = _graphAlignment.y + details.delta.dy / dragResistance;
        print(dy);

        setState(() {
            _graphAlignment = Alignment(dx, dy); 
        });

        print(_graphAlignment);
    }

    Widget _buildNode() {

        return RawMaterialButton(
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.red,
            autofocus: false,
            padding: const EdgeInsets.all(15.0),
            onPressed: (){
                print('Pressed Node');
            },
        );

    }

}
import 'package:flutter/material.dart';


class PanoramaView extends StatefulWidget {

    PanoramaView({Key key}) : super(key: key);

    @override 
    _PanoramaViewState createState() => _PanoramaViewState();
}


class _PanoramaViewState extends State<PanoramaView> {

    Alignment _imageAlignment = Alignment.center;
    bool _showAppBar = true;
    
    final double dragResistance = 200;

    /*  Some test image urls
        https://www.worldphoto.org/sites/default/files/Mohammad%20Reza%20Domiri%20Ganji%2C%20Iran%20%2C%20Shortlist%2C%20Open%2C%20Panoramic%2C%202015%20Sony%20World%20Photography%20Awards%20%282%29.jpg
        https://cdn.pixabay.com/photo/2017/03/05/00/34/panorama-2117310_960_720.jpg
        https://saffi3d.files.wordpress.com/2011/08/commercial_area_cam_v004.jpg
    */
    final String imageUrl = 'https://www.worldphoto.org/sites/default/files/Mohammad%20Reza%20Domiri%20Ganji%2C%20Iran%20%2C%20Shortlist%2C%20Open%2C%20Panoramic%2C%202015%20Sony%20World%20Photography%20Awards%20%282%29.jpg';
    NetworkImage networkImage;

    @override 
    initState() {
        super.initState();

        networkImage = NetworkImage(imageUrl);
    }

    _toggleAppBar() {
        print('toggled the AppBar');
        setState(() {
        _showAppBar = !_showAppBar;
        });
    }

    @override 
    Widget build(BuildContext context) {

        return Stack(
            children: <Widget>[
                SizedBox.expand(
                    child: Image(
                        image: networkImage,
                        fit: BoxFit.fitHeight,
                        alignment: _imageAlignment,
                    )
                ),
                Scaffold(
                    backgroundColor: Colors.transparent,
                    appBar: _showAppBar ? _buildAppBar() : null,
                    body: GestureDetector(
                        onTap: _toggleAppBar,
                        onHorizontalDragUpdate: _dragImage,
                    ),
                ),
            ]
        );
    }   


    Widget _buildAppBar() {
        return AppBar(
            leading: BackButton(),
            
            backgroundColor: Colors.transparent,
            elevation: 0.0,
        );
    }


    // FIXME: for now the values are hard coded
    // TODO: figure out a way of getting the size of the image and relating it to the alignment
    // probably need to get the width of the screen since it corresponds to 2 alignment units
    _dragImage(DragUpdateDetails details) {
        double dx = _imageAlignment.x - details.delta.dx / dragResistance;

        if (dx > 2.0)
            dx = -2.0;
        else if (dx < -2.0)
            dx = 2.0;

        setState(() {
            _imageAlignment = Alignment(dx, 0.0);
        });

        print(_imageAlignment);
    }


}
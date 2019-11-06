import 'package:flutter/material.dart';


class PanoramaView extends StatefulWidget {

    PanoramaView({Key key}) : super(key: key);

    @override 
    _PanoramaViewState createState() => _PanoramaViewState();
}


class _PanoramaViewState extends State<PanoramaView> {

    static double delta = 2.697;

    Alignment _imageAlignment = Alignment.center;
    Alignment _imageAlignment2 = Alignment(delta,0);
    bool _showAppBar = true;
    
    final double dragResistance = 200;

    /*  Some test image urls
        https://www.worldphoto.org/sites/default/files/Mohammad%20Reza%20Domiri%20Ganji%2C%20Iran%20%2C%20Shortlist%2C%20Open%2C%20Panoramic%2C%202015%20Sony%20World%20Photography%20Awards%20%282%29.jpg
        https://cdn.pixabay.com/photo/2017/03/05/00/34/panorama-2117310_960_720.jpg
        https://saffi3d.files.wordpress.com/2011/08/commercial_area_cam_v004.jpg
    */
    final String imageUrl = 'https://saffi3d.files.wordpress.com/2011/08/commercial_area_cam_v004.jpg';
    NetworkImage networkImage;
    Image testImage;
    Widget test;
    GlobalKey  imageKeyNormal = GlobalKey();
    GlobalKey  imageKey = GlobalKey();

    Size imageSize;
    Size imageSize2;


    @override 
    initState() {
        WidgetsBinding.instance.addPostFrameCallback(getimageSize);
        super.initState();

        networkImage = NetworkImage(imageUrl);

        test = SizedBox.expand(
            child: Image(
                image: networkImage,
                fit: BoxFit.fitHeight,

                alignment: _imageAlignment,
            ),
        );


    }

    getimageSize(_){
        RenderBox renderBoxRed = imageKey.currentContext.findRenderObject();
        imageSize = renderBoxRed.size;
        print("SIZE of Red: $imageSize");
        print(imageSize.width);
        print(imageSize.width/145.613);
        RenderBox renderBoxRed2 = imageKeyNormal.currentContext.findRenderObject();
        imageSize2 = renderBoxRed2.size;
        print("SIZE of Red: $imageSize2");
        print(imageSize2.width);
        print(imageSize2.width/145.613);
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
                SizedBox(
                    child: Image(
                        image: networkImage,
                        fit: BoxFit.fitHeight,
                        alignment: _imageAlignment,
                    ),
                    key: imageKey,
                ),
                SizedBox.expand(
                    child: Image(
                        image: networkImage,
                        fit: BoxFit.fitHeight,
                        alignment: _imageAlignment2,
                    ),
                ),
                SizedBox.expand(
                    child: Image(
                        image: networkImage,
                        fit: BoxFit.contain,
                        alignment: Alignment(3,3),
                        key: imageKeyNormal,
                    ),
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
        double dx2 = _imageAlignment2.x - details.delta.dx / dragResistance;

        if (dx > delta)
            dx -= 2*delta;
        else if (dx < -delta)
            dx += 2*delta;

        if (dx2 > delta)
            dx2 -= 2*delta;
        else if (dx2 < -delta)
            dx2 += 2*delta;

        setState(() {
            _imageAlignment = Alignment(dx, 0.0);
            _imageAlignment2 = Alignment(dx2, 0.0);
        });

        print(_imageAlignment);
        /*print(testImage);*/
    }


}
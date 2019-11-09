import 'package:flutter/material.dart';


class Tag {
    final String text;
    final double x;
    final double y;
    Tag(this.text,this.x,this.y);

    Alignment getAlignment(){
        return Alignment(x,y);
    }
    String getText(){
        return text;
    }

}

class PanoramaView extends StatefulWidget {

    PanoramaView({Key key , this.tags}) : super(key: key);

    final List<Tag> tags;

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
        https://www.worldphoto.org/sites/default/files/Mohammad%20Reza%20Domiri%20Ganji%2C%20Iran%20%2C%20Shortlist%2C%20Open%2C%20Panoramic%2C%202015%20Sony%20World%20Photography%20Awards%20%282%29.jpg  2000 × 990
        https://cdn.pixabay.com/photo/2017/03/05/00/34/panorama-2117310_960_720.jpg 960 × 355  2.5
        https://saffi3d.files.wordpress.com/2011/08/commercial_area_cam_v004.jpg    3072 × 1536 2.697
    */
    //final String imageUrl = 'https://www.worldphoto.org/sites/default/files/Mohammad%20Reza%20Domiri%20Ganji%2C%20Iran%20%2C%20Shortlist%2C%20Open%2C%20Panoramic%2C%202015%20Sony%20World%20Photography%20Awards%20%282%29.jpg';
    //final String imageUrl = 'https://cdn.pixabay.com/photo/2017/03/05/00/34/panorama-2117310_960_720.jpg';
    final String imageUrl = 'https://saffi3d.files.wordpress.com/2011/08/commercial_area_cam_v004.jpg';
    NetworkImage networkImage;
    Image testImage;
    Widget test;
    GlobalKey  imageKey1 = GlobalKey();
    GlobalKey  imageKey2 = GlobalKey();

    Size imageSize;
    Size imageSize2;


    @override
    initState() {
        WidgetsBinding.instance.addPostFrameCallback(getImageSize);
        super.initState();

        networkImage = NetworkImage(imageUrl);

        var a = networkImage.toString();
        print(a);

        test = SizedBox.expand(
            child: Image(
                image: networkImage,
                fit: BoxFit.fitHeight,

                alignment: _imageAlignment,
            ),
        );


    }

    getImageSize(_){
        RenderBox renderBoxRed = imageKey1.currentContext.findRenderObject();
        imageSize = renderBoxRed.size;
        print("SIZE of Red: $imageSize");
        print(imageSize.width);
        print(imageSize.width/145.613);
        RenderBox renderBoxRed2 = imageKey2.currentContext.findRenderObject();
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

        List<Widget> stackChildren = [
            SizedBox.expand(
                child: Image(
                    image: networkImage,
                    fit: BoxFit.fitHeight,
                    alignment: _imageAlignment,
                    key: imageKey1,
                ),
            ),
            SizedBox.expand(

                child: Image(
                    image: networkImage,
                    fit: BoxFit.fitHeight,
                    alignment: _imageAlignment2,
                    key: imageKey2,
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
        ];

        for(int i = 0; i < widget.tags.length;i++){
            stackChildren.add(
                Align(
                    alignment: widget.tags[i].getAlignment() -_imageAlignment-_imageAlignment - _imageAlignment  -_imageAlignment,
                    child: FlatButton(
                        onPressed: () {
                            //TODO: place here a useful function
                            print(widget.tags[i].getText());
                        },
                        color: Colors.blue,
                        child: Container(
                            padding: EdgeInsets.all(8.0),
                            color: Colors.blue,
                            child: Text(widget.tags[i].getText()),
                        ),
                    )
                )
            );
        }

        for(int i = 0; i < widget.tags.length;i++){
            stackChildren.add(
                Align(
                    alignment: widget.tags[i].getAlignment() -_imageAlignment2-_imageAlignment2 - _imageAlignment2  -_imageAlignment2,
                    child: FlatButton(
                        onPressed: () {
                            //TODO: place here a useful function
                            print(widget.tags[i].getText());
                        },
                        color: Colors.blue,
                        child: Container(
                            padding: EdgeInsets.all(8.0),
                            color: Colors.blue,
                            child: Text(widget.tags[i].getText()),
                        ),
                    )
                )
            );
        }



        return Stack(
            children: stackChildren
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
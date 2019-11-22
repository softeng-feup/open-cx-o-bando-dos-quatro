import 'dart:async';

import 'package:flutter/material.dart';
import 'package:confview/conference.dart';


class PanoramaView extends StatefulWidget {

    PanoramaView({Key key , this.panoramaImage,this.tags}) : super(key: key);

    final List<Tag> tags;
    final PanoramaViewImage panoramaImage;

    @override 
    _PanoramaViewState createState() => _PanoramaViewState();
}


class _PanoramaViewState extends State<PanoramaView> {

    double delta = 2.4733;

    Alignment _imageAlignment = new Alignment(0,0);
    Alignment _imageAlignment2 = new Alignment(2.4733,0);
    bool _showAppBar = true;
    final double dragResistance = 200;

    /*  Some test image urls
        https://www.worldphoto.org/sites/default/files/Mohammad%20Reza%20Domiri%20Ganji%2C%20Iran%20%2C%20Shortlist%2C%20Open%2C%20Panoramic%2C%202015%20Sony%20World%20Photography%20Awards%20%282%29.jpg  2000 × 990
        https://cdn.pixabay.com/photo/2017/03/05/00/34/panorama-2117310_960_720.jpg 960 × 355  2.5
        https://saffi3d.files.wordpress.com/2011/08/commercial_area_cam_v004.jpg    3072 × 1536 2.697
    */
    //final String imageUrl = 'https://www.worldphoto.org/sites/default/files/Mohammad%20Reza%20Domiri%20Ganji%2C%20Iran%20%2C%20Shortlist%2C%20Open%2C%20Panoramic%2C%202015%20Sony%20World%20Photography%20Awards%20%282%29.jpg';
    final String imageUrl = 'https://cdn.pixabay.com/photo/2017/03/05/00/34/panorama-2117310_960_720.jpg';
    //final String imageUrl = 'https://d159gdcp8gotlc.cloudfront.net/assets/banner/2742561_1.jpg';
    NetworkImage networkImage;


    bool loaded = false;

    double width;
    double height;



    @override
    initState() {

        super.initState();


        loadImage();



    }

    void loadImage() async{
        if(this.loaded)
            return;
        final myFuture = getImage();
        myFuture.then(setValues);
        this.loaded = true;
    }

    void setValues(bool data) async{

        print("Cheguei aqui!");

        double x = this.width / this.height ;

        delta = 1.03041/(x + -0.520507) + 2.00104;

        this._imageAlignment = Alignment(0,0);
        this._imageAlignment2 = Alignment(delta,0);


        return;
    }

    Future<bool> getImage() async {


        Completer<bool> completer = Completer();

        this.networkImage = NetworkImage(widget.panoramaImage.imageUrl);

        NetworkImage config = await this.networkImage.obtainKey(const ImageConfiguration());
        ImageStreamCompleter load = networkImage.load(config);

        ImageStreamListener listener = new ImageStreamListener((ImageInfo info, isSync) async {
            print(info.image.width);
            print(info.image.height);
            this.width = info.image.width.toDouble();
            this.height = info.image.height.toDouble();
            completer.complete(true);
        });

        load.addListener(listener);
        return completer.future;
    }



    _toggleAppBar() {
        print('toggled the AppBar');
        setState(() {
        _showAppBar = !_showAppBar;
        });
    }

    @override
    Widget build(BuildContext context) {


        if(this.loaded == false){
            List<Widget> stackChildren =  [];
            return Stack(
                children: stackChildren
            );
        }

        List<Widget> stackChildren =  [
            Container(
                constraints: BoxConstraints.expand(),
                child: Image(
                    image: networkImage,
                    fit: BoxFit.fitHeight,
                    alignment: _imageAlignment,
                ),
            ),
            Container(
                constraints: BoxConstraints.expand(),
                child: Image(
                    image: networkImage,
                    fit: BoxFit.fitHeight,
                    alignment: _imageAlignment2,
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
                            Navigator.pop(context);
                            Navigator.pushNamed(context, '/' + widget.tags[i].getText());
                            //Navigator.of(context).pushNamed('/' + widget.tags[i].getText());
                            //print(widget.tags[i].getText());
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
                            Navigator.pushNamed(context, '/' + widget.tags[i].getText());
                            //Navigator.of(context).pushNamed('/' + widget.tags[i].getText());
                            //print(widget.tags[i].getText());
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
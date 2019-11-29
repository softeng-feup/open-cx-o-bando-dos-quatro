import 'dart:async';

import 'package:flutter/material.dart';
import 'package:confview/conference.dart';


class PanoramaView extends StatefulWidget {

    PanoramaView({Key key , Location location}) : super(key: key){
        this.panoramaImage = location.image;
        this.tags = location.tags;
    }

    List<Tag> tags;
    PanoramaViewImage panoramaImage;

    @override 
    _PanoramaViewState createState() => _PanoramaViewState();
}


class _PanoramaViewState extends State<PanoramaView> {

    double delta = 2.8;

    Alignment _imageAlignment = new Alignment(0,0);
    Alignment _imageAlignment2 = new Alignment(0,0);
    bool _showAppBar = true;
    final double dragResistance = 200;

    NetworkImage networkImage;


    bool loaded = false;

    double imageWidth;
    double imageHeight;
    static double screenWidth;
    static double screenHeight;

    GlobalKey imageKey1 = new GlobalKey();



    @override
    initState() {
        if(!this.widget.panoramaImage.loaded)
            WidgetsBinding.instance.addPostFrameCallback(getImageSize);


        super.initState();

        this.delta = 2.455;

        loadImage();



    }

    getImageSize(_){
        RenderBox renderBoxRed = imageKey1.currentContext.findRenderObject();
        final imageSize = renderBoxRed.size;

        screenWidth = imageSize.width;
        screenHeight = imageSize.height;


        if(this.imageWidth != null && this.imageHeight != null)
            this.delta = 1.99068/((this.imageWidth * screenHeight) / (this.imageHeight * screenWidth) + -1.0072) + 2.00054;

        this._imageAlignment = Alignment(0,0);
        this._imageAlignment2 = Alignment(this.delta,0);

    }

    void loadImage() async{
        if(this.widget.panoramaImage.loaded){
            this.networkImage = this.widget.panoramaImage.networkImage;
            this.imageWidth = this.widget.panoramaImage.width;
            this.imageHeight = this.widget.panoramaImage.height;
            setValues(true);
            return;
        }else {
            final myFuture = getImage();
            myFuture.then(setValues);
        }
    }

    void setValues(bool data) async{

        this.delta = 1.99068/((this.imageWidth * screenHeight) / (this.imageHeight * screenWidth) + -1.0072) + 2.00054;

        //print("Calculation of delta: " + this.delta.toString());

        this._imageAlignment = Alignment(0,0);
        this._imageAlignment2 = Alignment(this.delta,0);

        this.loaded = true;
        setState(() {   });

        return;
    }

    Future<bool> getImage() async {

        Completer<bool> completer = Completer();

        this.networkImage = NetworkImage(widget.panoramaImage.imageUrl);

        NetworkImage config = await this.networkImage.obtainKey(const ImageConfiguration());
        ImageStreamCompleter load = networkImage.load(config);

        ImageStreamListener listener = new ImageStreamListener((ImageInfo info, isSync) async {
            //print(info.image.width);
            //print(info.image.height);
            this.imageWidth = info.image.width.toDouble();
            this.imageHeight = info.image.height.toDouble();
            widget.panoramaImage.networkImage = this.networkImage;
            widget.panoramaImage.width = this.imageWidth;
            widget.panoramaImage.height = this.imageHeight;
            widget.panoramaImage.loaded = true;
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
            return Scaffold(
                key : imageKey1,
                backgroundColor: Colors.white10,
                body: Center(
                    child: Text('Loading' , style: TextStyle(color: Colors.white, fontSize: 20),)),
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
                            //Navigator.pushNamed(context, '/' + widget.tags[i].getText());
                            //Navigator.pushReplacementNamed(context, widget.tags[i].getText());
                            Navigator.pop(context);
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => PanoramaView(location : widget.tags[i].location)));
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
            stackChildren.add(
                Align(
                    alignment: widget.tags[i].getAlignment() -_imageAlignment2-_imageAlignment2 - _imageAlignment2  -_imageAlignment2,
                    child: FlatButton(
                        onPressed: () {
                            //Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => PanoramaView(location : widget.tags[i].location)));
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

        //print(_imageAlignment);
        /*print(testImage);*/
    }


}
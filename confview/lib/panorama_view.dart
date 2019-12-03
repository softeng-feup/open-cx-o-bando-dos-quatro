import 'dart:async';
import 'dart:math';

import 'package:confview/conferenceViewer.dart';
import 'package:flutter/material.dart';

class PanoramaView extends StatefulWidget {
  PanoramaView({Key key, this.locations, this.location}) : super(key: key) {
    this.panoramaImage = this.location.image;
    print(this.locations);
  }

  PanoramaViewImage panoramaImage;
  Location location;
  List<Location> locations;

  @override
  _PanoramaViewState createState() => _PanoramaViewState();
}

class _PanoramaViewState extends State<PanoramaView> {
  double delta = 2.8;

  Alignment _imageAlignment = new Alignment(0, 0);
  Alignment _imageAlignment2 = new Alignment(0, 0);
  bool _showAppBar = true;
  final double dragResistance = 200;

  NetworkImage networkImage;

  bool loaded = false;

  double imageWidth;
  double imageHeight;
  static double screenWidth;
  static double screenHeight;

  GlobalKey imageKey1 = new GlobalKey();

  TextEditingController _searchQuery;
  bool _isSearching = false;
  String searchQuery = "Search query";
  FocusNode _searchFocus;

  @override
  initState() {
    if (!this.widget.panoramaImage.loaded)
      WidgetsBinding.instance.addPostFrameCallback(getImageSize);

    super.initState();

    this.delta = 2.455;
    _searchQuery = new TextEditingController();
    _searchFocus = FocusNode();

    loadImage();
  }

  getImageSize(_) {
    RenderBox renderBoxRed = imageKey1.currentContext.findRenderObject();
    final imageSize = renderBoxRed.size;

    screenWidth = imageSize.width;
    screenHeight = imageSize.height;

    if (this.imageWidth != null && this.imageHeight != null)
      this.delta = 1.99068 /
              ((this.imageWidth * screenHeight) /
                      (this.imageHeight * screenWidth) +
                  -1.0072) +
          2.00054;

    this._imageAlignment = Alignment(0, 0);
    this._imageAlignment2 = Alignment(this.delta, 0);
  }

  void loadImage() async {
    if (this.widget.panoramaImage.loaded) {
      this.networkImage = this.widget.panoramaImage.networkImage;
      this.imageWidth = this.widget.panoramaImage.width;
      this.imageHeight = this.widget.panoramaImage.height;
      setValues(true);
      return;
    } else {
      final myFuture = getImage();
      myFuture.then(setValues);
    }
  }

  void setValues(bool data) async {
    this.delta = 1.99068 /
            ((this.imageWidth * screenHeight) /
                    (this.imageHeight * screenWidth) +
                -1.0072) +
        2.00054;

    //print("Calculation of delta: " + this.delta.toString());

    this._imageAlignment = Alignment(0, 0);
    this._imageAlignment2 = Alignment(this.delta, 0);

    this.loaded = true;
    setState(() {});

    return;
  }

  Future<bool> getImage() async {
    Completer<bool> completer = Completer();

    this.networkImage = NetworkImage(widget.panoramaImage.imageUrl);

    NetworkImage config =
        await this.networkImage.obtainKey(const ImageConfiguration());
    ImageStreamCompleter load = networkImage.load(config);

    ImageStreamListener listener =
        new ImageStreamListener((ImageInfo info, isSync) async {
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

  @override
  dispose() {
    _searchFocus.dispose();
    super.dispose();
  }

  _startSearch() {
    setState(() {
      _isSearching = true;
    });
  }

  _stopSearch() {
    _clearSearchQuery();
    setState(() {
      _isSearching = false;
    });
  }

  _clearSearchQuery() {
    print("close search box");
    setState(() {
      _searchQuery.clear();
      _updateSearchQuery("Search query");
    });
  }

  _updateSearchQuery(String newQuery) {
    setState(() {
      _isSearching = true;
      searchQuery = newQuery;
    });
    print("search query : " + newQuery);
    shortestPath(widget.locations, newQuery);
  }

  _toggleAppBar() {
    print('toggled the AppBar');
    setState(() {
      _showAppBar = !_showAppBar;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (this.loaded == false) {
      return Scaffold(
        key: imageKey1,
        backgroundColor: Colors.white10,
        body: Center(
            child: Text(
          'Loading',
          style: TextStyle(color: Colors.white, fontSize: 20),
        )),
      );
    }

    List<Widget> stackChildren = [
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

    for (int i = 0; i < widget.location.tags.length; i++) {
      Widget tagContainer = Container(
        padding: EdgeInsets.all(8.0),
        child: Text(widget.location.tags[i].getText()),
      );
      Widget child1;
      print(widget.location.tags[i].getText()+ "->" + widget.location.tags[i].getAlignment().toString());
      if (widget.location.tags[i].getText() == widget.location.path) {
        child1 = Align(
            alignment: widget.location.tags[i].getAlignment() * this.delta -
                _imageAlignment -
                _imageAlignment -
                _imageAlignment -
                _imageAlignment,
            child: FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PanoramaView(
                          locations: widget.locations,
                          location: widget.location.tags[i].dest)));
                },
                color: Colors.redAccent,
                child: tagContainer));
      } else {
        child1 = Align(
            alignment: widget.location.tags[i].getAlignment() * this.delta -
                _imageAlignment -
                _imageAlignment -
                _imageAlignment -
                _imageAlignment,
            child: FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PanoramaView(
                          locations: widget.locations,
                          location: widget.location.tags[i].dest)));
                },
                color: Colors.blue,
                child: tagContainer));
      }
      stackChildren.add(child1);

      Widget child2;
      if (widget.location.tags[i].getText() == widget.location.path) {
        child2 = Align(
            alignment: widget.location.tags[i].getAlignment() * this.delta -
                _imageAlignment2 -
                _imageAlignment2 -
                _imageAlignment2 -
                _imageAlignment2,
            child: FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PanoramaView(
                          locations: widget.locations,
                          location: widget.location.tags[i].dest)));
                },
                color: Colors.redAccent,
                child: tagContainer));
      } else {
        child2 = Align(
            alignment: widget.location.tags[i].getAlignment() * this.delta -
                _imageAlignment2 -
                _imageAlignment2 -
                _imageAlignment2 -
                _imageAlignment2,
            child: FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PanoramaView(
                          locations: widget.locations,
                          location: widget.location.tags[i].dest)));
                },
                color: Colors.blue,
                child: tagContainer));
      }
      stackChildren.add(child2);
    }

    return Stack(children: stackChildren);
  }

  Widget _buildAppBar() {
    return AppBar(
      leading: BackButton(),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      title: TextField(
        controller: _searchQuery,
        focusNode: _searchFocus,
        onChanged: _updateSearchQuery,
        onTap: _startSearch,
        decoration: InputDecoration(
          hintText: 'Search...',
        ),
      ),
      //actions: _buildActions(),
      /* TODO: create our own AppBar widget
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                */
    );
  }

  // FIXME: for now the values are hard coded
  // TODO: figure out a way of getting the size of the image and relating it to the alignment
  // probably need to get the width of the screen since it corresponds to 2 alignment units
  _dragImage(DragUpdateDetails details) {
    double dx = _imageAlignment.x - details.delta.dx / dragResistance;
    double dx2 = _imageAlignment2.x - details.delta.dx / dragResistance;

    if (dx > delta)
      dx -= 2 * delta;
    else if (dx < -delta) dx += 2 * delta;

    if (dx2 > delta)
      dx2 -= 2 * delta;
    else if (dx2 < -delta) dx2 += 2 * delta;

    setState(() {
      _imageAlignment = Alignment(dx, 0.0);
      _imageAlignment2 = Alignment(dx2, 0.0);
    });

    //print(_imageAlignment);
    /*print(testImage);*/
  }
}


double dist(Location l1, Location l2) {
  return sqrt(pow(l1.getX() - l2.getX(), 2) + pow(l1.getY() - l2.getY(), 2));
}

//shortest path assuming the conections are bi-derectional
void shortestPath(List<Location> locations, String dest) {
  List<Location> toVisit = new List<Location>();
  bool found = false;
  for (int i = 0; i < locations.length; i++) {
    locations[i].visited = false;
    locations[i].distance = double.maxFinite;
    locations[i].path = "";
    if (locations[i].getName() == dest) {
      toVisit.add(locations[i]);
      locations[i].distance = 0;
      found = true;
    }
    toVisit.add(locations[i]);
  }
  if (!found) return;

  while (toVisit.isNotEmpty) {
    Location nextLocation;
    double minDist = double.maxFinite;
    int index = 0;
    for (int i = 0; i < toVisit.length; i++) {
      if (toVisit[i].distance < minDist) {
        nextLocation = toVisit[i];
        minDist = toVisit[i].distance;
        index = i;
      }
    }

    toVisit.removeAt(index);

    for (int i = 0; i < nextLocation.tags.length; i++) {
      if (nextLocation.tags[i].dest.distance >
          minDist + dist(nextLocation, nextLocation.tags[i].dest)) {
        nextLocation.tags[i].dest.distance =
            minDist + dist(nextLocation, nextLocation.tags[i].dest);
        nextLocation.tags[i].dest.path = nextLocation.getName();
      }
    }
  }

  for (int i = 0; i < locations.length; i++) {
    print(locations[i].getName() + " -> " + locations[i].path);

  }
}


import 'package:confview/graph_draw.dart';
import 'package:confview/graph.dart';
import 'package:confview/map_data.dart';

import 'package:confview/conferenceViewer.dart';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'nfc.dart';

class MapScreen extends StatefulWidget {
  final int conferenceId;

  //List<Node> locations = new List<Node>();

  Graph graph = new Graph();

  MapScreen({Key key, this.conferenceId}) : super(key: key) {
    getConferenceInfo();
  }

  @override
  _MapScreenState createState() => _MapScreenState();

  //TODO:: get info from database
  void getConferenceInfo() {

    graph.addNode(Node(0,"Praia","https://upload.wikimedia.org/wikipedia/commons/3/3e/Croatia_Ribarica_beach_panorama_360.jpg",0, 0));
    graph.addNode(Node(1,"India" ,"https://l13.alamy.com/360/PN0HYA/ganesh-pol-amber-palace-rajasthan-india-PN0HYA.jpg",  90, 45));
    graph.addNode(Node(2, "Rua", "https://saffi3d.files.wordpress.com/2011/08/commercial_area_cam_v004.jpg", 180, 0));
    graph.addNode(Node(3,"Cidade", "https://c1.staticflickr.com/5/4302/35137573294_1287bfd0ae_k.jpg" , 90, 90));

    graph.addEdge(0, 1);
    graph.addEdge(0, 2);
    graph.addEdge(3, 2);

    /*this.locations.add(new Location(
        "Praia",
        new PanoramaViewImage(
            "https://upload.wikimedia.org/wikipedia/commons/3/3e/Croatia_Ribarica_beach_panorama_360.jpg"),
        -2,
        -8));

    this.locations.add(new Location(
        "India",
        new PanoramaViewImage(
            "https://l13.alamy.com/360/PN0HYA/ganesh-pol-amber-palace-rajasthan-india-PN0HYA.jpg"),
        4,
        2));

    this.locations.add(new Location(
        "Rua",
        new PanoramaViewImage(
            "https://saffi3d.files.wordpress.com/2011/08/commercial_area_cam_v004.jpg"),
        -5,
        -4));

    this.locations.add(new Location(
        "Cidade",
        new PanoramaViewImage(
            "https://c1.staticflickr.com/5/4302/35137573294_1287bfd0ae_k.jpg"),
        0,
        0));

    this.locations.add(new Location(
        "Cidade2",
        new PanoramaViewImage(
            "https://d36tnp772eyphs.cloudfront.net/blogs/1/2006/11/360-panorama-matador-seo.jpg"),
        -3,
        2));

    List<Edge> edges = new List<Edge>();
    edges.add(new Edge("Rua","Praia"));
    edges.add(new Edge("Rua","Cidade"));
    edges.add(new Edge("Cidade","Cidade2"));
    edges.add(new Edge("Cidade","India"));
    edges.add(new Edge("India","Cidade2"));
    edges.add(new Edge("Rua","Cidade2"));

    for(int a = 0;a<edges.length;a++){

      for(int b = 0; b < locations.length;b++){
        if(edges[a].getOrigin() == locations[b].getName()){
          for(int c = 0; c < locations.length;c++){
            if(edges[a].getDest() == locations[c].getName()) {
              locations[b].addTag2(locations[c], 0.0 + b, 0);
              locations[c].addTag2(locations[b], 0.0 + b, 0);
            }
          }
        }
      }

    }*/

  }
}

class _MapScreenState extends State<MapScreen> {
  TextEditingController _searchQuery;
  bool _isSearching = false;
  String searchQuery = "Search query";
  FocusNode _searchFocus;
  
  initState() {
    super.initState();
    _searchQuery = new TextEditingController();
    _searchFocus = FocusNode();
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
  }

  @override
  Widget build(BuildContext context) {
    Widget floatingActionButton1 = FloatingActionButton(
      child: Icon(Icons.nfc),
      tooltip: 'Read NFC tag',
      onPressed: _readTag,
    );

    Widget floatingActionButton2 = FloatingActionButton(
      child: Icon(Icons.airplay),
      tooltip: 'Read NFC tag',
      onPressed: _readTag,
    );

    return Scaffold(
      appBar: AppBar(
        leading: _isSearching ? _buildBackButton() : null,
        title: TextField(
          controller: _searchQuery,
          focusNode: _searchFocus,
          onChanged: _updateSearchQuery,
          onTap: _startSearch,
          decoration: InputDecoration(
            hintText: 'Search...',
          ),
        ),
        actions: _buildActions(),
        /* TODO: create our own AppBar widget
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                */
      ),
      body: _isSearching ? _buildSuggestions() : _buildMap(),
      floatingActionButton: _getFAB(),
    );
  }

  
  Widget _getFAB() {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 22),
      backgroundColor: Color(0xFF801E48),
      visible: true,
      curve: Curves.bounceIn,
      children: [
        // FAB 1
        SpeedDialChild(
            child: Icon(Icons.directions),
            backgroundColor: Colors.blue,
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ConferenceViewer(
                        locations: widget.graph.getNodes(), startIndex: 0,
                      )));
            },
            label: 'GO',
            labelStyle: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 16.0),
            labelBackgroundColor: Color(0xFF801E48)),
        // FAB 2
        SpeedDialChild(
            child: Icon(Icons.nfc),
            backgroundColor: Colors.blue,
            onTap: () {
              _readTag();
            },
            label: 'NFC',
            labelStyle: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 16.0),
            labelBackgroundColor: Color(0xFF801E48))
      ],
    );
  }


  Widget _buildSuggestions() {
    print(searchQuery);
    return Center(child: Text('Suggestions go here : ' + searchQuery));
  }


  Widget _buildMap() {
      return GraphDraw(graph: widget.graph,);
  }


  Widget _buildButtons() {
    return Column(
      children: [
        FloatingActionButton(
          child: Icon(Icons.nfc),
          tooltip: 'Read NFC tag',
          onPressed: _readTag,
        ),
        FloatingActionButton(
            child: Icon(Icons.directions),
            tooltip: 'Start navigation',
            onPressed: () {
              print('Pressed START NAVIGATION');
            }),
      ],
    );
  }

  _readTag() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => NfcScan()));
  }

  List<Widget> _buildActions() {
    if (!_isSearching)
      return <Widget>[
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            FocusScope.of(context).requestFocus(_searchFocus);
            _startSearch();
          },
        ),
      ];

    return <Widget>[
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: _clearSearchQuery,
      ),
    ];
  }

  Widget _buildBackButton() {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: _stopSearch,
      // TODO: probably the focus will need to be changed here
    );
  }
}


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

  static Graph graph = new Graph();

  static int currentConference = -1;

  static final _formKey = GlobalKey<FormState>();

  MapScreen({Key key, this.conferenceId}) : super(key: key) {
    getConferenceInfo();
  }

  @override
  _MapScreenState createState() => _MapScreenState();

  //TODO:: get info from database
  void getConferenceInfo() {

    if(currentConference == this.conferenceId){
      return;
    }
    currentConference = this.conferenceId;
    graph = new Graph();

    /*graph.addNode(Node(0,"Praia","https://upload.wikimedia.org/wikipedia/commons/3/3e/Croatia_Ribarica_beach_panorama_360.jpg",0, 0));
    graph.addNode(Node(1,"India" ,"https://l13.alamy.com/360/PN0HYA/ganesh-pol-amber-palace-rajasthan-india-PN0HYA.jpg",  90, 45));
    graph.addNode(Node(2, "Rua", "https://saffi3d.files.wordpress.com/2011/08/commercial_area_cam_v004.jpg", 180, 0));
    graph.addNode(Node(3,"Cidade", "https://c1.staticflickr.com/5/4302/35137573294_1287bfd0ae_k.jpg" , 90, 90));

    graph.addEdge(0, 1);
    graph.addEdge(0, 2);
    graph.addEdge(3, 2);*/

    graph.addNode(Node(0,"Sala","https://www.realtourvision.com/wp-content/uploads/2012/11/2.jpg",0, 0));
    graph.addNode(Node(1,"Cave","http://www.tasmania360.com//panoramas/Highfield-House-Stanley-03/thumb_huge.jpg",70, 0));
    graph.addNode(Node(2,"Casa de Banho","https://img-new.cgtrader.com/items/729948/ecb94768f1/panorama-chinese-style-bathroom-toilet-space-02-3d-model-max.jpg",70, 80));
    graph.addNode(Node(3,"Cozinha","https://www.imagesolutionsindia.com/cdn/images/Image-editing/360-photo-editing-services.jpg",-40, 40));

    graph.addNode(Node(4,"Sotão","https://media.blendernation.com/wp-content/uploads/2018/06/Chocofur_Interior_Scene_03_360_LR.jpg",0, -40));
    graph.addNode(Node(5,"Jardim","https://cdn.eso.org/images/thumb300y/ESO_Guesthouse_360_Marcio_Cabral_Chile_01-CC.jpg",0, 80));
    graph.addNode(Node(6,"Quarto","http://www.prophotocompany.co.uk/images/panorama/panorama07.jpg",50, 40));

    graph.addEdge(0, 5);
    graph.addEdge(0, 3);
    graph.addEdge(0, 1);
    graph.addEdge(0, 4);
    graph.addEdge(0, 6);
    graph.addEdge(6, 2);
    graph.addEdge(6, 1);
    graph.addEdge(3, 5);

    print('fecthed graph');

  }



}

class _MapScreenState extends State<MapScreen> {


  final TextEditingController _filter = new TextEditingController();
  String _searchText = "";
  List names = new List(); // names we get from API
  List filteredNames = new List(); // names filtered by search text
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text( 'Search Example' );
  bool isSearching = false;

  
  initState() {
    super.initState();
    _getNames();
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredNames = names;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

  void _getNames()  {

    setState(() {
      names = MapScreen.graph.getNodes();
      filteredNames = names;
    });
    print(names);
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
          controller: _filter,
          decoration: new InputDecoration(
              prefixIcon: new Icon(Icons.search),
              hintText: 'Search...'
          ),
        );
        isSearching = true;
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = new Text('Search Example');
        filteredNames = names;
        _filter.clear();
        isSearching = false;
      }
    });
  }

  Widget _buildList() {
    for (int i = 0; i < filteredNames.length; i++) {
      filteredNames[i].selected = false;
    }
    if (_searchText.isNotEmpty) {
      List tempList = new List();
      for (int i = 0; i < filteredNames.length; i++) {
        if (filteredNames[i].getName().toLowerCase().contains(_searchText.toLowerCase())) {
          tempList.add(filteredNames[i]);
          filteredNames[i].selected = true;
        }
      }
      filteredNames = tempList;
    }
    
    return ListView.builder(
      itemCount: names == null ? 0 : filteredNames.length,
      itemBuilder: (BuildContext context, int index) {
        return new ListTile(
          title: Text(filteredNames[index].getName()),
          onTap: () {
            print(filteredNames[index].getName());
            _searchPressed();
            for (int i = 0; i < filteredNames.length; i++) {
                filteredNames[i].selected = false;
            }
            filteredNames[index].selected = true;
            isSearching = false;
          },
        );
      },
    );
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
        leading:  _buildBackButton(),
        title: this._appBarTitle,
        actions: _buildActions(),
        /* TODO: create our own AppBar widget
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                */
      ),
      body: isSearching ? _buildList() :_buildMap(),
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
                        locations: MapScreen.graph.getNodes(), startIndex: 0,
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





  Widget _buildMap() {
      return GraphDraw(graph: MapScreen.graph,);
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
        .push(MaterialPageRoute(builder: (context) => NfcScan(locations: MapScreen.graph.getNodes())));
  }

  List<Widget> _buildActions() {
      return <Widget>[
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: _searchPressed,
        ),
      ];

  }

  Widget _buildBackButton() {
    return BackButton();
  }

  @override
  void dispose() {
    MapScreen.currentConference = -1;
    super.dispose();
  }

}

import 'package:flutter/material.dart';
import 'nfc.dart';


class MapScreen extends StatefulWidget {

    final int conferenceId;

    MapScreen({Key key, this.conferenceId}) : super(key: key);

    @override 
    _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

    TextEditingController _searchQuery;
    bool _isSearching = false;
    String searchQuery = "Search query";
    FocusNode _searchFocus;


    @override 
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
        );
    }

    Widget _buildSuggestions() {
        print(searchQuery);
        return Center(
            child: Text('Suggestions go here : ' + searchQuery)
        );
    }

    Widget _buildMap() {
        print(_isSearching);
        
        return FloatingActionButton(
            child: Icon(Icons.nfc),
            tooltip: 'Read NFC tag',
            onPressed: _readTag,
        );
        
    }

    _readTag() {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => NfcScan()));
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
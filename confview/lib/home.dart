import 'package:flutter/material.dart';

import 'action_item.dart';
import 'nav.dart';

import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';



class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> {
  // TODO: the app must get the conference names from the database
  List<Map<String, dynamic>> _conferences = [];

  @override
  void initState() {
    super.initState();
    readConferences().then((String lines) {
      setState(() {
        print("Lines  " + lines);
        List<dynamic> linesDecoded = jsonDecode(lines);
        print(linesDecoded);
        for(int i = 0; i < linesDecoded.length;i++){
          Map<String, dynamic> line = linesDecoded[i];
          _conferences.add(line);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _buildList(),
      floatingActionButton: FloatingActionButton(
        // TODO: display the pop up window
        onPressed: () {
          _displayDialog(context);
        }, //_buildDialog,
        tooltip: 'Add new conference',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildList() {
    return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemBuilder: (BuildContext _context, int i) {
          final int index = i ~/ 2;

          if (index >= _conferences.length) return null;

          if (i.isOdd) return Divider();

          return _buildRow(index);
        });
  }

  // TODO: change the parameter, InkWell is temporary(incorporate into OnSlide)
  Widget _buildRow(int index) {
    return InkWell(
        child: OnSlide(
          items: <ActionItem>[
            ActionItem(
                icon: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {},
                    color: Colors.red),
                onPress: () {
                  _deleteConference(index);
                },
                backgroundColor: Colors.white),
          ],
          child: Container(
              padding: const EdgeInsets.only(top: 10.0),
              width: 200.0,
              height: 150.0,
              child: Card(
                child: Row(
                  children: <Widget>[Text(_conferences[index]['name'])],
                ),
              )),
        ),
        onTap: () {
          // TODO: this is temporary, change the parameter so that the map screen is built for the correct conference
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => MapScreen(conferenceId: int.parse(_conferences[index]['code'])  ) ));
        });
  }

  _displayDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return _buildDialog(context);
        });
  }

  Widget _buildDialog(BuildContext context) {
    TextEditingController textController = TextEditingController();

    return AlertDialog(
      title: Text('Add Conference'),
      content: TextField(
          decoration: InputDecoration(
            hintText: 'CODE',
            border: OutlineInputBorder(),
          ),
          textCapitalization: TextCapitalization.characters,
          textAlign: TextAlign.center,
          maxLines: 1,
          maxLength: 15,
          // TODO: this is a temporary value
          controller: textController,
          autocorrect: false,
          autofocus: true,
          onSubmitted: (text) {
            _addNewConference(text, context);
          }),
      actions: <Widget>[
        MaterialButton(
          onPressed: () {
            _addNewConference(textController.text, context);
          },
          child: Text('Submit'),
        )
      ],
    );
  }

  _addNewConference(String conferenceCode, BuildContext context) async{
    print('Checking if it is possible to create a new conf');
    if(conferenceCode == '') return;
    for(int i = 0; i < _conferences.length;i++){
      if(_conferences[i]['code'] == conferenceCode){
        Navigator.pop(context);
        return;
      }
    }
    var url = 'https://gnomo.fe.up.pt/~up201706534/website/api/fetch_conference.php';
    var response = await http.post(url, body: {'conference_code': conferenceCode});
    //print('Response status: ${response.statusCode}');
    //print('Response body: ${response.body}');
    List<dynamic> map;
    try {
      map = jsonDecode(response.body);
    }on Exception catch(e){
      return;
    }
    print(map);
    Map<String, dynamic> conferenceInfo = map[0];
    Map<String, dynamic> addedInfo = new Map();
    addedInfo['name'] = conferenceInfo['confName'];
    addedInfo['code'] = conferenceInfo['code'];

    setState(() {
      print('Created a new conference');
      _conferences.add(addedInfo);
    });
    writeConference();
    Navigator.pop(context);
  }

  _deleteConference(int index) {
    setState(() {
      _conferences.removeAt(index);
      writeConference();
    });
  }






  Future<String> get _localPath async {
    String dir = (await getApplicationDocumentsDirectory()).path;

    return dir;
  }

  Future<File> get _conferecesFile async {
    final path = await _localPath;
    return File('$path/conferences.txt');
  }

  Future<File> writeConference() async {
    final file = await _conferecesFile;

    // Write the file.
    print('Writen to file');
    String toWrite = "[";
    for(int i = 0; i<_conferences.length;i++){
      toWrite+="{\"name\":\""+_conferences[i]['name']+"\",\"code\":\""+_conferences[i]['code']+"\"}";
      if(i!=_conferences.length-1){
        toWrite+=",";
      }
    }
    toWrite +="]";
    print("I am going to write:  " + toWrite);
    return file.writeAsString(toWrite);
  }

  Future<String> readConferences() async {
    try {
      final file = await _conferecesFile;

      Future<String> lines;
      // Read the file.
      lines = file.readAsString();

      return lines;
    } catch (e) {
      // If encountering an error, return 0.
      return "[]";
    }
  }




  _openConference() {}
}

import 'package:flutter/material.dart';

import 'action_item.dart';
import 'nav.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // TODO: the app must get the conference names from the database
  final List<String> _conferences = ["Web Summit", "Talk A Bit"];

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
                  children: <Widget>[Text(_conferences[index])],
                ),
              )),
        ),
        onTap: () {
          // TODO: this is temporary, change the parameter so that the map screen is built for the correct conference
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => MapScreen(conferenceId: index)));
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

  _addNewConference(String conferenceName, BuildContext context) {
    print('Checking if it is possible to create a new conf');
    if (conferenceName == '') return;

    setState(() {
      print('Created a new conference');
      _conferences.add(conferenceName);
    });

    Navigator.pop(context);
  }

  _deleteConference(int index) {
    setState(() {
      _conferences.removeAt(index);
    });
  }

  _openConference() {}
}

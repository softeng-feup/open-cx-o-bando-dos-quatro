import 'package:flutter/material.dart';
import 'action_item.dart';



class HomePage extends StatefulWidget {
    HomePage({Key key, this.title}) : super(key: key);

    final String title;

    @override
    _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

    // TODO: the app must get the conference names from the database
    final List<String> _conferences = ["conf1", "conf2"];


    @override
    Widget build(BuildContext context) {

        return Scaffold(
            appBar: AppBar(
                title: Text(widget.title),
            ),

            body: _buildList(),

            floatingActionButton: FloatingActionButton(
                // TODO: display the pop up window
                onPressed: (){
                    _displayDialog(context);
                },//_buildDialog,
                tooltip: 'Add new conference',
                child: Icon(Icons.add),
            ),
        );
    }

    Widget _buildList() {
        return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemBuilder: (BuildContext _context, int i) {
                if (i.isOdd) {
                    return Divider();
                }
                final int index = i ~/ 2;
                if (index < _conferences.length)
                    return _buildRow(_conferences[index]);

                return null;
            }
        );  
    }

    // TODO: change the parameter
    Widget _buildRow(String conferenceName) {
        return OnSlide(
            items: <ActionItem>[
                ActionItem(
                    icon: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: (){},
                        color: Colors.red),
                    onPress: (){},
                    backgroundColor: Colors.white),  
                ],
            child:
                Container(
                padding: const EdgeInsets.only(top:10.0),
                width: 200.0,
                height: 150.0,
                child: Card(
                    child: Row(
                        children: <Widget>[
                            Text(conferenceName)
                            ],
                        ),
                    )
                )
        );
    }


    _displayDialog(BuildContext context) {
        return showDialog(
            context: context,
            builder: (context) {
                return _buildDialog(context);
            }
        );
    }

       
    Widget _buildDialog(BuildContext context) {

        TextEditingController textController = TextEditingController();

        return AlertDialog(
            title: Text('Add Conference'),
            content: TextField(
                decoration: InputDecoration(hintText: 'Conference Code'),
                controller: textController,
                autocorrect: false,
                autofocus: true,
                onSubmitted: _addNewConference(textController.text, context)
                ),
            actions: <Widget>[
                MaterialButton(
                    onPressed: (){
                        _addNewConference(textController.text, context);
                    },
                    child: Text('Submit'),
                    )
            ],
        );
    }

    _addNewConference(String conferenceName, BuildContext context) {
        if ( conferenceName == '')
            return;

        setState(() {
        _conferences.add(conferenceName);
        });

        Navigator.pop(context);
    }
}



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nfc_reader/flutter_nfc_reader.dart';

import 'conferenceViewer.dart';
import 'map_data.dart';

class NfcScan extends StatefulWidget {
  NfcScan({Key key, this.locations}) : super(key: key);

  final List<Node> locations;

  @override
  _NfcScanState createState() => _NfcScanState();
}

class _NfcScanState extends State<NfcScan> {
  bool _nfcOn = true;

  @override
  initState() {
    super.initState();
    NfcData data;
    _readTag(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            tooltip: 'Go back',
            onPressed: () {
              _stopReadingTag();
              Navigator.pop(context);
            },
          ),
        ),
        body: Center(
          child: _nfcOn
              ? Text('Looking for NFC tag...')
              : Text('NFC not found or enable..'),
        ));
  }

  _readTag(data) {
    String location = "";
    try {
      FlutterNfcReader.read().then((response) {
        /*response = data;
                print('Read a tag');
                print(data.id);
                print(data.content);*/
        //print(response.content);
        //print(response.toString());
        //print(response.id);
        setState(() {
          _nfcOn = true;
        });

        location = response.content.substring(7);
        print(location);

        int index = -1;
        for (int i = 0; i < widget.locations.length; i++) {
          if (widget.locations[i].getName() == location) {
            index = i;
            break;
          }
        }

        if (index != -1) {
          Navigator.of(context).pop();
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ConferenceViewer(
                    locations: widget.locations,
                    startIndex: index,
                  )));
          _stopReadingTag();
        }
      }).catchError((e) {
        setState(() {
          _nfcOn = false;
        });
      });
    } catch (e) {
      print(e.toString());
      setState(() {
        _nfcOn = false;
      });
      print("a");
    } finally {}
  }

  _stopReadingTag() {
    if (!_nfcOn) return;

    try {
      FlutterNfcReader.stop().then((response) {
        print(response.status.toString());
        print('Stopped trying to read a tag');
      });
    } catch (exception) {
      print(exception.toString());
    }
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_nfc_reader/flutter_nfc_reader.dart';

class NfcScan extends StatefulWidget {
  NfcScan({Key key}) : super(key: key);

  @override
  _NfcScanState createState() => _NfcScanState();
}

class _NfcScanState extends State<NfcScan> {
  @override
  initState() {
    super.initState();

    try {
      FlutterNfcReader.read().then((data) {
        print('Read a tag');
        print(data.id);
        print(data.content);
        Navigator.pop(context);
      });
    } on PlatformException catch (exception) {
      print(exception);
      // TODO: display a dialog box warning to turn on nfc
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            tooltip: 'Go back',
            onPressed: () {
              FlutterNfcReader.stop().then((response) {
                print(response.status.toString());
                print('Stopped trying to read a tag');
              });
              Navigator.pop(context);
            },
          ),
        ),
        body: Center(
          child: Text('Looking for NFC tag...'),
        ));
  }
}

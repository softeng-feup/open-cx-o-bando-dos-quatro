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
                    onPressed: (){
                        _stopReadingTag();
                        Navigator.pop(context);
                    },
                ),
            ),
            body: Center(
                child: Text('Looking for NFC tag...'),
            )
        );
    }

    _readTag(data) {
        try {
            FlutterNfcReader.read().then((response) {
                response = data;
                print('Read a tag');
                print(data.id);
                print(data.content);
            });
        } catch(exception) {
            print(exception.toString());
        } finally {
            _nfcOn = false;
            // TODO: show a dialog box that warns when nfc is not on
        }
    }

    _stopReadingTag() {
        if (!_nfcOn)
            return;

        try {
            FlutterNfcReader.stop().then((response) {
                print(response.status.toString());
                print('Stopped trying to read a tag');
            });
        } catch(exception) {
            print(exception.toString());
        }
    }
}


import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ButtonPage extends StatefulWidget {
  ButtonPage({required this.deviceName});
  final String deviceName;
  @override
  _ButtonPageState createState() => _ButtonPageState();
}

class _ButtonPageState extends State<ButtonPage> {
  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.reference().child('user');
  bool _isLightOn = false;
  late int status;
  void _toggleLight() {
    setState(() {
      _isLightOn = !_isLightOn;
    });
    status = _isLightOn == false ? 0 : 1;
    _databaseReference.child("device/${widget.deviceName}/status").set(status);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Light'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _isLightOn ? 'Light is ON' : 'Light is OFF',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _toggleLight,
              child: Text(_isLightOn ? 'Turn OFF' : 'Turn ON'),
            ),
          ],
        ),
      ),
    );
  }
}

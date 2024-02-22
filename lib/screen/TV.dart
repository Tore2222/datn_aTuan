import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class TVRemoteControl extends StatefulWidget {
  @override
  _TVRemoteControlState createState() => _TVRemoteControlState();
}

class _TVRemoteControlState extends State<TVRemoteControl> {
  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.reference().child('user');
  String _tvStatus = 'OFF';
  int _channel = 0;

  void _togglePower() {
    setState(() {
      _tvStatus = _tvStatus == 'OFF' ? 'ON' : 'OFF';
    });
    _databaseReference.child('device/device5/mode').set(10);
    _databaseReference.child('device/device5/status').set(1);
  }

  void _changeChannel(int newChannel) {
    setState(() {
      _channel = newChannel;
    });
    _databaseReference.child('device/device5/mode').set(newChannel);
    _databaseReference.child('device/device5/status').set(1);
  }

  void _volumeUp() {
    _databaseReference.child('device/device5/mode').set(11);
    _databaseReference.child('device/device5/status').set(1);
  }

  void _volumeDown() {
    // Implement volume down functionality
    _databaseReference.child('device/device5/mode').set(12);
    _databaseReference.child('device/device5/status').set(1);
  }

  void _mute() {
    // Implement mute functionality
    _databaseReference.child('device/device5/mode').set(15);
    _databaseReference.child('device/device5/status').set(1);
  }

  void _channelUp() {
    // Implement channel up functionality
    _databaseReference.child('device/device5/mode').set(13);
    _databaseReference.child('device/device5/status').set(1);
  }

  void _channelDown() {
    // Implement channel down functionality
    _databaseReference.child('device/device5/mode').set(14);
    _databaseReference.child('device/device5/status').set(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TV Remote Control'),
      ),
      body: Center(
        child: Container(
          width: 300,
          height: 600,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'TV Status: $_tvStatus',
                style: TextStyle(fontSize: 24),
              ),
              Text(
                'Channel: $_channel',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _togglePower,
                child: Text('POW'),
              ),
              SizedBox(height: 10),
              ListView(
                shrinkWrap: true,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 0; i < 3; i++)
                        ElevatedButton(
                          onPressed: () => _changeChannel(i),
                          child: Text(i.toString()),
                        ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 3; i < 6; i++)
                        ElevatedButton(
                          onPressed: () => _changeChannel(i),
                          child: Text(i.toString()),
                        ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 6; i < 9; i++)
                        ElevatedButton(
                          onPressed: () => _changeChannel(i),
                          child: Text(i.toString()),
                        ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () => _changeChannel(9),
                        child: Text('9'),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: _volumeUp,
                        child: Text('+V'),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: _volumeDown,
                        child: Text('-V'),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: _channelUp,
                        child: Text('+'),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: _channelDown,
                        child: Text('-'),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: _mute,
                        child: Text('MUTE'),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class baochayscreen extends StatefulWidget {
  @override
  _PumpAndFanState createState() => _PumpAndFanState();
}

class _PumpAndFanState extends State<baochayscreen> {
  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.reference().child('user');
  late bool isPumpOn = false;
  late bool isFanOn = false;
  late int check1;
  late int check2;
  @override
  void initState() {
    _setupDCtream();
    _setupFantream();
    super.initState();
  }

  void _setupDCtream() {
    DatabaseReference Pump = FirebaseDatabase.instance
        .ref()
        .child('/user/device/device4/control_DC');

    Pump.onValue.listen((event) {
      final dynamic data = event.snapshot.value;

      if (data != null) {
        setState(() {
          isPumpOn = data.toDouble() == 0 ? false : true;
          print(isPumpOn);
          // Kiểm tra nếu gas = 1 thì hiển thị thông báo kèm đổ chuông
        });
      }
    });
  }

  void _setupFantream() {
    DatabaseReference Fan = FirebaseDatabase.instance
        .ref()
        .child('/user/device/device4/control_Quat');

    Fan.onValue.listen((event) {
      final dynamic data = event.snapshot.value;

      if (data != null) {
        setState(() {
          isFanOn = data.toDouble() == 0 ? false : true;
          // Kiểm tra nếu gas = 1 thì hiển thị thông báo kèm đổ chuông
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              isPumpOn = !isPumpOn;
            });
            check1 = isPumpOn ? 1 : 0;
            _databaseReference.child('device/device4/control_DC').set(check1);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: isPumpOn ? Colors.green : null,
          ),
          child: Text('Pump'),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            setState(() {
              isFanOn = !isFanOn;
            });
            check2 = isFanOn ? 1 : 0;
            _databaseReference.child('device/device4/control_Quat').set(check2);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: isFanOn ? Colors.green : null,
          ),
          child: Text('Fan'),
        ),
      ],
    );
  }
}

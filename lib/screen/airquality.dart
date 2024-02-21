import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AirQualityScreen extends StatefulWidget {
  @override
  State<AirQualityScreen> createState() => _AirQualityScreenState();
}

class _AirQualityScreenState extends State<AirQualityScreen> {
  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.reference().child('user');
  List<Map<String, dynamic>> airquality = [];

  @override
  void initState() {
    _databaseReference.child('air_quality2').onValue.listen((event) {
      var snapshot = event.snapshot;
      if (snapshot.value != null) {
        var data = snapshot.value as Map<dynamic, dynamic>;
        setState(() {
          airquality = data.entries.map((entry) {
            return {'type': entry.key, 'value': entry.value.toString()};
          }).toList();
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AirQuality'),
        centerTitle: true, // Center the title
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InfoContainer(
              text: airquality[0]['type'],
              data: airquality[0]['value'],
            ),
            InfoContainer(
              text: airquality[1]['type'],
              data: airquality[1]['value'],
            ),
            InfoContainer(
              text: airquality[2]['type'],
              data: airquality[2]['value'],
            ),
            InfoContainer(
              text: airquality[3]['type'],
              data: airquality[3]['value'],
            ),
          ],
        ),
      ),
    );
  }
}

class InfoContainer extends StatelessWidget {
  final String text;
  final String data;

  InfoContainer({required this.text, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          Text(
            "$data µg/m³ ",
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          
        ],
      ),
    );
  }
}

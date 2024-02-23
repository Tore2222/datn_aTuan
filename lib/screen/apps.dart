import 'package:class_management/box/TVbutton.dart';
import 'package:class_management/box/custom_card.dart';
import 'package:class_management/screen/TV.dart';
import 'package:class_management/screen/airquality.dart';
import 'package:class_management/screen/baochay.dart';
import 'package:class_management/screen/button_on_off.dart';
import 'package:class_management/screen/lightcontrol.dart';
import 'package:class_management/screen/notification.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

import 'package:audioplayers/audioplayers.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class Apps extends StatefulWidget {
  const Apps({
    super.key,
  });

  @override
  State<Apps> createState() => _AppsState();
}

class _AppsState extends State<Apps> with TickerProviderStateMixin {
  Future<void> showNotificationWithSound() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id', // Thay đổi thành ID kênh thông báo của bạn
      'Tên kênh',
      playSound: true,
      importance: Importance.high,
      priority: Priority.high,
      sound: RawResourceAndroidNotificationSound(
          'coi'), // Tùy chỉnh âm thanh thông báo
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      0, // ID thông báo
      'Thông báo phát hiện khí gas',
      'Mọi người cần xử lý,thoát hiểm ngay',
      platformChannelSpecifics,
      payload:
          'Custom_Sound', // Payload tùy chọn để xử lý khi thông báo được nhấn
    );
  }

  void sound() async {
    print("test1");
    AudioPlayer player = new AudioPlayer();
    const alarmAudioPath = "assets/music/coi.mp3";
    player.play(alarmAudioPath as Source);
    AssetsAudioPlayer.newPlayer().open(Audio("assets/music/coi.mp3"));
  }

  Future<void> showNotificationWithSound1() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'Chay', // Thay đổi thành ID kênh thông báo của bạn
      'Tên kênh',
      playSound: true,
      importance: Importance.high,
      priority: Priority.high,
      sound: RawResourceAndroidNotificationSound(
          'coi'), // Tùy chỉnh âm thanh thông báo
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );
    sound();
    await flutterLocalNotificationsPlugin.show(
      0, // ID thông báo
      'Thông báo phát hiện lửa',
      'Mọi người cần xử lý,thoát hiểm ngay',
      platformChannelSpecifics,
      payload:
          'Custom_Sound', // Payload tùy chọn để xử lý khi thông báo được nhấn
    );
  }

  int dusty = 0;
  List<Map<String, dynamic>> Device = [];
  late TabController _tabController;
  late List<Widget> _views; // Declare the variable here
  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.reference().child('user');
  @override
  void dispose() {
    // ignore: todo
    // TODO: implement dispose

    super.dispose();
  }

  @override
  void initState() {
    for (int i = 0; i < 6; i++) {
      Device.add({"name": "", "status": 0});
    }
    updateDevice();
    int data = 0;
    // ignore: todo
    // TODO: implement initState
    _tabController = TabController(length: 4, vsync: this);
    _tabController.animateTo(2);
    print('test');
    Future.delayed(const Duration(seconds: 1), () {});

    _setupkhiGasStream();
    _setupkhiBurnStream();
    Noti.initializeNotifications(flutterLocalNotificationsPlugin);
    super.initState();
  }

  void _setupkhiGasStream() {
    DatabaseReference gasReference1 =
        FirebaseDatabase.instance.ref().child('/user/device/device4/gas');

    gasReference1.onValue.listen((event) {
      final dynamic data = event.snapshot.value;

      if (data != null) {
        setState(() {
          double gas = data.toDouble();
          print(gas);
          // Kiểm tra nếu gas = 1 thì hiển thị thông báo kèm đổ chuông
          if (gas == 1) {
            print('kham');
            showNotificationWithSound1();
          }
        });
      }
    });
  }

  void _setupkhiBurnStream() {
    DatabaseReference burnReference1 =
        FirebaseDatabase.instance.ref().child('/user/device/device4/fire');

    burnReference1.onValue.listen((event) {
      final dynamic data = event.snapshot.value;

      if (data != null) {
        setState(() {
          double burn = data.toDouble();
          print(burn);
          // Kiểm tra nếu gas = 1 thì hiển thị thông báo kèm đổ chuông
          if (burn == 0) {
            print('kham');
            showNotificationWithSound1();
          }
        });
      }
    });
  }

  @override
  void toggle_d1() {
    //setState(() {
    if (Device[0]['status'] == 0) {
      _databaseReference.child('device/device1/status').set(1);
    } else {
      _databaseReference.child('device/device1/status').set(0);
    }
    //});
  }

  void toggle_d2() {
    if (Device[1]['status'] == 0) {
      _databaseReference.child('device/device2/status').set(1);
    } else {
      _databaseReference.child('device/device2/status').set(0);
    }
  }

  void toggle_d3() {
    if (Device[2]['mode'] == 0) {
      _databaseReference.child('device/device3/mode').set(1);
    } else {
      _databaseReference.child('device/device3/mode').set(0);
    }
  }

  void toggle_d4() {
    if (Device[3]['status'] == 0) {
      _databaseReference.child('device/device4/status').set(1);
    } else {
      _databaseReference.child('device/device4/status').set(0);
    }
  }

  void toggle_d5() {
    // if (Device[4]['mode'] == 10 && Device[4]['status'] == 0) {
    //   _databaseReference.child('device/device5/mode').set(1);
    // } else {
    //   _databaseReference.child('device/device5/status').set(0);
    // }
  }

  // void toggle_d6() {
  //   if (Device[5]['status'] == 0) {
  //     _databaseReference.child('device/device6/status').set(1);
  //   } else {
  //     _databaseReference.child('device/device6/status').set(0);
  //   }
  // }

  /// List of Tab Bar Item
  List<String> items = [
    "ClassRoom",
    // "Kitchen",
    // "BedRoom",
    // "OutSide",
  ];
  final List<Tab> _tabs = [
    Tab(
      child: Center(
        child: Text("ClassRoom",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              color: Colors.black,
            )),
      ),
    ),
  ];

  int current = 0;

  void updateDevice() {
    _databaseReference.child('device').onValue.listen((event) {
      if (event.snapshot != null) {
        DataSnapshot snapshot = event.snapshot as DataSnapshot;
        Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;

        List<Map<String, dynamic>> settings3 = [];

        data.forEach(
          (key, value) {
            if (value != null && value is Map<dynamic, dynamic>) {
              if (value.containsKey('name')) {
                settings3.add(
                  {
                    'mode': value['mode'] != null
                        ? int.parse(value['mode'].toString())
                        : 0,
                    'name': value['name'].toString(),
                    'status': int.parse(value['status'].toString()),
                  },
                );
              }
              ;
            }
          },
        );
        setState(() {
          Device = settings3;
          for (int i = 0; i < settings3.length; i++) {
            print('settigngs3[$i] status: ${settings3[i]['mode']}');
            print('settigngs3[$i] name: ${settings3[i]['name']}');
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      /// APPBAR
      //appBar: AppBar(),

      ///Điện năng tiêu thụ
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          AirQualityScreen()), // Replace AirQualityScreen() with your actual screen
                );
              },
              child: Container(
                child: Center(
                  child: Container(
                      width: 300,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.blue,
                          width: 2,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Container(
                              width: 90,
                              height: 90,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(90),
                              ),
                              child: Center(
                                child: Image.asset(
                                  'assets/images/ic_dusty.jpg',
                                  width: 90,
                                  height: 90,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    "Temp : ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontFamily: 'Roboto',
                                    ),
                                  ),
                                  StreamBuilder(
                                    stream: _databaseReference.onValue,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData &&
                                          !snapshot.hasError &&
                                          snapshot.data!.snapshot.value !=
                                              null) {
                                        // Truy cập dữ liệu từ snapshot
                                        Map<dynamic, dynamic> data = snapshot
                                            .data!
                                            .snapshot
                                            .value as Map<dynamic, dynamic>;

                                        String temp = data['temp'].toString();

                                        return Text(
                                          '$temp %',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: Colors.black,
                                            fontFamily: 'Roboto',
                                          ),
                                        );
                                      } else {
                                        return CircularProgressIndicator();
                                      }
                                    },
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  const Text(
                                    "Humi : ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontFamily: 'Roboto',
                                    ),
                                  ),
                                  StreamBuilder(
                                    stream: _databaseReference.onValue,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData &&
                                          !snapshot.hasError &&
                                          snapshot.data!.snapshot.value !=
                                              null) {
                                        // Truy cập dữ liệu từ snapshot
                                        Map<dynamic, dynamic> data = snapshot
                                            .data!
                                            .snapshot
                                            .value as Map<dynamic, dynamic>;

                                        String humi = data['humi'].toString();

                                        return Text(
                                          '$humi %',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: Colors.black,
                                            fontFamily: 'Roboto',
                                          ),
                                        );
                                      } else {
                                        return CircularProgressIndicator();
                                      }
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  StreamBuilder(
                                    stream: _databaseReference.onValue,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData &&
                                          !snapshot.hasError &&
                                          snapshot.data!.snapshot.value !=
                                              null) {
                                        // Truy cập dữ liệu từ snapshot
                                        Map<dynamic, dynamic> data = snapshot
                                            .data!
                                            .snapshot
                                            .value as Map<dynamic, dynamic>;

                                        dusty =
                                            int.parse(data['dusty'].toString());

                                        return Text(
                                          '$dusty',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.black,
                                            fontFamily: 'Roboto',
                                          ),
                                        );
                                      } else {
                                        return CircularProgressIndicator();
                                      }
                                    },
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    'µg/m³',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontFamily: 'Roboto',
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                dusty <= 40 ? "Safe" : "Danger",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                  color:
                                      dusty <= 40 ? Colors.black : Colors.red,
                                ),
                              ),
                            ],
                          )
                        ],
                      )),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.all(size.width * 0.05),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: size.height * 0.025),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomCard(
                            size: size,
                            icon: Icon(
                              Icons.lightbulb_outline,
                              size: 55,
                              color: Colors.grey.shade400,
                            ),
                            title: Device[0]['name'],
                            //title: "Đèn",
                            statusOn: "ON",
                            statusOff: "OFF",
                            isChecked: Device[0]['status'] == 0 ? false : true,
                            toggle: toggle_d1,
                            onLongPress: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      LightControlScreen(deviceName: "device1"),
                                ),
                              );
                            }),
                        CustomCard(
                          size: size,
                          icon: Icon(
                            Icons.door_back_door,
                            size: 55,
                            color: Colors.grey.shade400,
                          ),
                          title: Device[1]['name'],
                          statusOn: "OPEN",
                          statusOff: "LOCKED",
                          isChecked: Device[1]['status'] == 0 ? false : true,
                          toggle: toggle_d2,
                          onLongPress: () {},
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.025),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomCard(
                            size: size,
                            icon: Icon(
                              Icons.lightbulb_outline,
                              size: 55,
                              color: Colors.grey.shade400,
                            ),
                            title: Device[2]['name'],
                            statusOn: "Auto",
                            statusOff: "Manual",
                            isChecked: Device[2]['mode'] == 0 ? false : true,
                            toggle: toggle_d3,
                            onLongPress: () {
                              if (Device[2]['mode'] == 0) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ButtonPage(deviceName: "device3"),
                                  ),
                                );
                              }
                            }),
                        CustomCardTV(
                          size: size,
                          icon: Icon(
                            Icons.fireplace_outlined,
                            size: 55,
                            color: Colors.grey.shade400,
                          ),
                          title: Device[3]['name'],
                          statusOn: "",
                          statusOff: "",
                          isChecked: Device[3]['status'] == 0 ? false : true,
                          toggle: toggle_d4,
                          onLongPress: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => baochayscreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.025),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomCardTV(
                            size: size,
                            icon: Icon(
                              Icons.desktop_mac_rounded,
                              size: 55,
                              color: Colors.grey.shade400,
                            ),
                            title: Device[4]['name'],
                            statusOn: "",
                            statusOff: "",
                            isChecked: Device[4]['status'] == 0 ? false : true,
                            toggle: toggle_d5,
                            onLongPress: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TVRemoteControl(),
                                ),
                              );
                            }),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

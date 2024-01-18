import 'package:flutter/material.dart';
import 'package:music/music.dart';
import 'package:on_audio_room/on_audio_room.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> main() async {
  await OnAudioRoom().initRoom();
  runApp(MaterialApp(
    home: plays(),
    debugShowCheckedModeBanner: false,
  ));
}

class plays extends StatefulWidget {
  @override
  State<plays> createState() => _playsState();
}

class _playsState extends State<plays> {
  bool p = false;

  @override
  void initState() {
    super.initState();
    per();
    Future.delayed(Duration(seconds: 3)).then((value) {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return music();
        },
      ));
    });
  }

  per() async {
    var status = await Permission.storage.status;
    if (status.isDenied) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.location,
        Permission.storage,
      ].request();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Music"),
      ),
      body: Container(
          alignment: Alignment.center,
          color: Colors.black,
          height: double.infinity,
          width: double.infinity,
          child: Text(
            "Music",
            style: TextStyle(fontSize: 25, color: Colors.white),
          )),
    );
  }
}

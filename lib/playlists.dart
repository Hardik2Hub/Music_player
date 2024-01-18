import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music/data.dart';
import 'package:music/fav_fullscreen.dart';
import 'package:on_audio_room/details/rooms/favorites/favorites_entity.dart';

class playlists extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    data m = Get.put(data());
    return Scaffold(
      body: FutureBuilder(
          future: m.get_fav(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              List<FavoritesEntity> l = snapshot.data as List<FavoritesEntity>;
              return Container(
                  alignment: Alignment.topCenter,
                  height: double.infinity,
                  width: double.infinity,
                  color: Colors.black,
                  child: Card(
                        color: Colors.black,
                        child: ListTile(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return fav_fullscreen();
                              },
                            ));
                          },
                          title: Text(
                            "Song",
                            maxLines: 1,
                            style: TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            "${l.length}",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                  ));
            } else {
              return Center(
                  child: Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.black,
                child: Center(
                  child: Container(
                    height: 40,
                    width: 40,
                    child: CircularProgressIndicator(
                      color: Colors.redAccent,
                    ),
                  ),
                ),
              ));
            }
          }),
    );
  }
}

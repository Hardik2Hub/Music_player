
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:music/albumpage.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'data.dart';

class albums extends StatelessWidget {
  List<Widget> icon = [
    Icon(Icons.people),
    Icon(Icons.downloading),
    Icon(Icons.playlist_add_outlined),
    Icon(Icons.headphones),
    Icon(Icons.access_time),
    Icon(Icons.share)
  ];
  List na = [
    "Unknown",
    "Download",
    "Add to Playlist",
    "Sound effect",
    "Set sleep timer",
    "Share song file",
  ];

  @override
  Widget build(BuildContext context) {
    data m = Get.put(data());
    return Scaffold(
      body: FutureBuilder(
          future: m.get_album(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              List<AlbumModel> l = snapshot.data as List<AlbumModel>;
              return Container(
                  alignment: Alignment.center,
                  height: double.infinity,
                  width: double.infinity,
                  color: Colors.black,
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: l.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.black,
                        child: ListTile(onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return albumpage(l[index]);
                          },));
                        },
                          title: Text(
                            "${l[index].album}",
                            maxLines: 1,
                            style: TextStyle(color: Colors.white),
                          ),
                          trailing: Wrap(children: [
                            Obx(() => m.cur_ind == index && m.isplay.value
                                ? Image.network(
                                height: 40,
                                "https://i.pinimg.com/originals/cb/17/b8/cb17b80a942d7c317a35ff1324fae12f.gif")
                                : Icon(
                                    Icons.more_vert,
                                    color: Colors.white,
                                  )),
                          ]),
                        ),
                      );
                    },
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

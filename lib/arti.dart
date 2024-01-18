import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:on_audio_room/on_audio_room.dart';

import 'data.dart';

class arti extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
    data m = Get.put(data());
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black),
      body: FutureBuilder(
          future: m.get_song(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              List<SongModel> l = snapshot.data as List<SongModel>;
              return Container(
                  alignment: Alignment.center,
                  height: double.infinity,
                  width: double.infinity,
                  color: Colors.black,
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: l.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          m.get_duration();
                          m.isplay.value = true;
                          if (m.cur_ind.value == index) {
                            m.get_check();
                            showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (context) {
                                return Container(
                                  alignment: Alignment.topCenter,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("      "),
                                            Text("      "),
                                            Text("      "),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("             "),
                                            IconButton(
                                              color: Colors.white,
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              icon: Icon(Icons
                                                  .keyboard_arrow_down_outlined),
                                            ),
                                            IconButton(
                                              color: Colors.white,
                                              onPressed: () {
                                                showModalBottomSheet(
                                                  context: context,
                                                  builder: (context) {
                                                    return Container(
                                                      color: Color(-14343646),
                                                      child: ListView.builder(
                                                        itemCount: icon.length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return Card(
                                                            color: Color(
                                                                -14343646),
                                                            child: ListTile(
                                                              iconColor:
                                                              Colors.white,
                                                              leading:
                                                              icon[index],
                                                              title: Text(
                                                                  "${na[index]}",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white)),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                              icon: Icon(Icons.more_vert),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                          flex: 1,
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: Center(
                                                  child: Obx(() => Text(
                                                      maxLines: 1,
                                                      "${m.song_list.value[m.cur_ind.value].title}",
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          color:
                                                          Colors.white))),
                                                ),
                                              ),
                                            ],
                                          )),
                                      Expanded(
                                        flex: 5,
                                        child: Center(
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.all(
                                                      Radius.circular(20)),
                                                  color: Colors.redAccent),
                                              child: Icon(Icons.music_note,
                                                  size: 200,
                                                  color: Colors.white)),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                                child: SliderTheme(
                                                    data: SliderTheme.of(
                                                        context)
                                                        .copyWith(
                                                        thumbShape:
                                                        RoundSliderThumbShape(
                                                            enabledThumbRadius:
                                                            5.0),
                                                        activeTrackColor:
                                                        Colors
                                                            .redAccent,
                                                        trackHeight: 2),
                                                    child: Obx(() => Slider(
                                                      min: 0,
                                                      max: m.song_list
                                                          .length >
                                                          0
                                                          ? m
                                                          .song_list
                                                          .value[m
                                                          .cur_ind
                                                          .value]
                                                          .duration!
                                                          .toDouble()
                                                          : 0,
                                                      value:
                                                      m.duration.value,
                                                      onChanged: (value) {},
                                                    ))))
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          children: [
                                            IconButton(
                                              onPressed: () {},
                                              icon: Icon(Icons.loop_outlined,
                                                  size: 20,
                                                  color: Colors.white),
                                            ),
                                            Obx(
                                                  () => m.fav.value
                                                  ? IconButton(
                                                onPressed: () async {
                                                  bool deleteFromResult =
                                                  await OnAudioRoom()
                                                      .deleteFrom(
                                                    RoomType.FAVORITES,
                                                    m.song_list.value[m.cur_ind.value]
                                                        .id,
                                                    //playlistKey,
                                                  );
                                                  m.get_check();
                                                },
                                                icon: Icon(Icons.favorite,
                                                    size: 20,
                                                    color: Colors.red),
                                              )
                                                  : IconButton(
                                                onPressed: () async {
                                                  int? addToResult =
                                                  await OnAudioRoom()
                                                      .addTo(
                                                    RoomType.FAVORITES,
                                                    m
                                                        .song_list
                                                        .value[m.cur_ind
                                                        .value]
                                                        .getMap
                                                        .toFavoritesEntity(),
                                                  );
                                                  m.get_check();
                                                },
                                                icon: Icon(
                                                    Icons.favorite_border,
                                                    size: 20,
                                                    color: Colors.white),
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {},
                                              icon: Icon(
                                                  Icons.playlist_add_check,
                                                  size: 20,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                if (m.cur_ind > 0) {
                                                  m.isplay.value = true;
                                                  m.cur_ind--;
                                                  data.player.play(
                                                      DeviceFileSource(m
                                                          .song_list
                                                          .value[
                                                      m.cur_ind.value]
                                                          .data));
                                                }
                                              },
                                              icon: Icon(
                                                  Icons.skip_previous_sharp,
                                                  size: 40,
                                                  color: Colors.white),
                                            ),
                                            Obx(
                                                  () => m.isplay.value
                                                  ? IconButton(
                                                  color: Colors.white,
                                                  onPressed: () {
                                                    data.player.pause();
                                                    m.isplay.value =
                                                    !m.isplay.value;
                                                  },
                                                  icon: Icon(
                                                    Icons.pause,
                                                    size: 60,
                                                  ))
                                                  : IconButton(
                                                  color: Colors.white,
                                                  onPressed: () {
                                                    m.isplay.value =
                                                    !m.isplay.value;
                                                    data.player.play(
                                                        DeviceFileSource(m
                                                            .song_list
                                                            .value[m.cur_ind
                                                            .value]
                                                            .data));
                                                  },
                                                  icon: Icon(
                                                    Icons.play_arrow,
                                                    size: 60,
                                                  )),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                if (m.cur_ind <
                                                    m.song_list.length - 1) {
                                                  m.isplay.value = true;
                                                  m.cur_ind++;
                                                  data.player.play(
                                                      DeviceFileSource(m
                                                          .song_list
                                                          .value[
                                                      m.cur_ind.value]
                                                          .data));
                                                }
                                              },
                                              icon: Icon(Icons.skip_next,
                                                  size: 40,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [],
                                        ),
                                      ),
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      tileMode: TileMode.repeated,
                                      colors: [
                                        Color(-11859960),
                                        Color(-15398133),
                                        Color(-15398133),
                                        Color(-15398133),
                                        Color(-12633542),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          } else {
                            m.cur_ind.value = index;
                            data.player.play(DeviceFileSource(
                                m.song_list.value[m.cur_ind.value].data));
                          }
                        },
                        child: Card(
                          color: Colors.black,
                          child: ListTile(
                            title: Text(
                              "${l[index].title}",
                              maxLines: 1,
                              style: TextStyle(color: Colors.white),
                            ),
                            trailing: Obx(() => m.cur_ind == index &&
                                m.isplay.value
                                ? Image.network(
                                height: 40,
                                "https://i.pinimg.com/originals/cb/17/b8/cb17b80a942d7c317a35ff1324fae12f.gif")
                                : Icon(
                              Icons.more_vert,
                              color: Colors.white,
                            )),
                          ),
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

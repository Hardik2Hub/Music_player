import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music/data.dart';
import 'package:music/playlists.dart';
import 'package:music/songs.dart';
import 'package:on_audio_room/on_audio_room.dart';

import 'albums.dart';
import 'artists.dart';

class music extends StatelessWidget {
  int cur_tab = 0;

  List str = ["Songs", "Artists", "Albums", "Playlists"];
  List<Widget> tab_class = [songs(), artists(), albums(), playlists()];
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
    m.get_duration();
    return DefaultTabController(
      animationDuration: Duration(milliseconds: 500),
      length: tab_class.length,
      child: Scaffold(
        appBar: AppBar(title: Text("Music",style: TextStyle(fontSize: 25,color: Colors.white)),
          actions: [
            Icon(Icons.search_rounded, color: Colors.white),
            PopupMenuButton(
              iconColor: Colors.white,
              color: Color(-14343646),
              itemBuilder: (context) => [
                PopupMenuItem(
                    child: Text(
                        style: TextStyle(color: Colors.white),
                        "Find local songs")),
                PopupMenuItem(
                    child:
                        Text(style: TextStyle(color: Colors.white), "Sort by")),
                PopupMenuItem(
                    child: Text(
                        style: TextStyle(color: Colors.white), "Manage songs")),
                PopupMenuItem(
                    child: Text(
                        style: TextStyle(color: Colors.white), "Settings")),
              ],
            )
          ],
          backgroundColor: Colors.black,
          bottom: TabBar(
            onTap: (value) {
              cur_tab = value;
            },
            indicatorWeight: 2,
            indicatorColor: Colors.red,
            unselectedLabelColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: Colors.red,
            tabs: str.map((e) {
              return Tab(
                child: Text('${e}', style: TextStyle(fontSize: 15)),
              );
            }).toList(),
          ),
        ),
        body: TabBarView(clipBehavior: Clip.antiAlias, children: tab_class),
        bottomNavigationBar: Container(
          color: Colors.black,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                      thumbShape:
                          RoundSliderThumbShape(enabledThumbRadius: 5.0),
                      activeTrackColor: Colors.redAccent,
                      trackHeight: 2),
                  child: Obx(() => Slider(
                        min: 0,
                        max: m.song_list.length > 0
                            ? m.song_list.value[m.cur_ind.value].duration!
                                .toDouble()
                            : 0,
                        value: m.duration.value,
                        onChanged: (value) {
                        },
                      ))),
              ListTile(
                title: Obx(() => m.song_list.value.isNotEmpty
                    ? InkWell(onTap: () {
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
                                        child: Obx(() =>  Text(
                                            maxLines: 1,
                                            "${m.song_list.value[m.cur_ind.value].title}",
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.white))),
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
                                      if(m.cur_ind>0)
                                      {
                                        m.isplay.value=true;
                                        m.cur_ind--;
                                        data.player.play(DeviceFileSource(
                                            m.song_list.value[m.cur_ind.value].data));
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
                                      if(m.cur_ind<m.song_list.length-1)
                                      {
                                        m.isplay.value=true;
                                        m.cur_ind++;
                                        data.player.play(DeviceFileSource(
                                            m.song_list.value[m.cur_ind.value].data));
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
                    },
                      child: Text(
                          maxLines: 1,
                          "${m.song_list.value[m.cur_ind.value].title}",
                          style: TextStyle(color: Colors.white),
                        ),
                    )
                    : Text("")),
                trailing: Obx(
                  () => m.isplay.value
                      ? IconButton(
                          color: Colors.white,
                          onPressed: () {
                            data.player.pause();
                            m.isplay.value = !m.isplay.value;
                          },
                          icon: Icon(Icons.pause))
                      : IconButton(
                          color: Colors.white,
                          onPressed: () {
                            m.isplay.value = !m.isplay.value;
                            data.player.play(DeviceFileSource(
                                m.song_list.value[m.cur_ind.value].data));
                          },
                          icon: Icon(Icons.play_arrow)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

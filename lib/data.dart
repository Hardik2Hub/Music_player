import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:on_audio_room/details/rooms/favorites/favorites_entity.dart';
import 'package:on_audio_room/on_audio_room.dart';

class data extends GetxController {


  RxList<SongModel> song_list = RxList();
  RxList<SongModel> getallalbum = RxList();
  RxList<ArtistModel> artist_list = RxList();
  RxList<AlbumModel> album_list = RxList();
  RxList<FavoritesEntity> fav_list = RxList();

  static OnAudioQuery audioQuery = OnAudioQuery();
  static AudioPlayer player = AudioPlayer();

  RxDouble duration = 0.0.obs;
  RxBool isplay = false.obs;

  RxInt cur_ind = 0.obs;
  RxBool fav = false.obs;

  get_song() async {
    song_list.value = await audioQuery.querySongs();
    return song_list;
  }

  get_duration() {
    player.onPositionChanged.listen((Duration d) {
      duration.value = d.inMilliseconds.toDouble();
    });
  }

  get_artist() async {
    artist_list.value = await audioQuery.queryArtists();
    return artist_list;
  }

  getallsong(int albumid) async {
    getallalbum.value =
        await audioQuery.queryAudiosFrom(AudiosFromType.ALBUM_ID, albumid);
    return getallsong;
  }

  get_album() async {
    album_list.value = await audioQuery.queryAlbums();
    return album_list;
  }

  get_fav() async {
    fav_list.value = await OnAudioRoom().queryFavorites();
    return fav_list;
  }

  get_check() async {
    fav.value = await OnAudioRoom().checkIn(RoomType.FAVORITES, song_list.value[cur_ind.value].id);
  }
}

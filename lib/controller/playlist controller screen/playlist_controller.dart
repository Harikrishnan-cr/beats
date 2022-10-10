import 'package:beat/database/model/music_model.dart';
import 'package:beat/main.dart';
import 'package:beat/view/splash%20screen/splash_screen.dart';
import 'package:get/get.dart';

final RxList<dynamic> playlistAddList = <dynamic>[].obs;
final RxList<MyMusicModel> playlistSongsFromDB = <MyMusicModel>[].obs;

class PlaylistController extends GetxController {
  Future<void> playListUpdate() async {
    playlistAddList.clear();
    final playlistKey = playlistDB.keys.toList();
    playlistAddList.value = playlistKey;
  }

  Future<void> playlistCreation(String key) async {
    bool keys = playlistDB.containsKey(key);
    if (keys) {
      return;
    }
    List<String> emptyList = [];
    await playlistDB.put(key, emptyList);
    playListUpdate();
  }

  Future<void> playlistDelete(String playlistname) async {
    playlistDB.delete(playlistname);
    playListUpdate();
  }

  Future<void> addtoPlaylistSongs(String id, String playlistname) async {
    if (tempPlaylistId.contains(id)) {
      return;
    }
    tempPlaylistId.add(id);
    await playlistDB.put(playlistname, tempPlaylistId);
    getPlaylistSongs(playlistname);
  }

  Future<void> getPlaylistSongs(String playlistname) async {
    tempPlaylistId = playlistDB.get(playlistname)!;

    playlistSongsFromDB.value = allAudioListFromDB.where((element) {
      return tempPlaylistId.contains(element.id);
    }).toList();
    playlistSongsFromDB.sort(
      (a, b) => a.musicName!.compareTo(b.musicName!),
    );
  }

  Future<void> playlistSongDelete(String id, String playlistname) async {
    tempPlaylistId.remove(id);
    playlistDB.put(playlistname, tempPlaylistId);
    await getPlaylistSongs(playlistname);
    //playlistSongsFromDB.notifyListeners();
    await playListUpdate();
  }

  Future<void> renamePlalistfunction(
      String playlistname, String newplaylistname) async {
    if (newplaylistname == "") {
      return;
    }
    List<String>? tempList = playlistDB.get(playlistname);
    tempList ??= [];
    await playlistDB.put(newplaylistname, tempList);
    await playlistDelete(playlistname);
    await playListUpdate();
  }

//-----------Playlist songs count ------------

  String playlistSongsCount(String? plalistName) {
    final val = playlistDB.get(plalistName);
    if (val!.isEmpty) {
      return '0';
    } else {
      return val.length.toString();
    }
  }
}





// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member



import 'package:beat/main.dart';
import 'package:beat/screens/splash%20screen/splash_screen.dart';
import 'package:beat/widget%20functions/widget_functions.dart';
import 'package:flutter/cupertino.dart';

//----------- Get All Music From DB - Start -----------------------------

Future<void> addAudiosToDB() async {

// await musicDB.put('all_songs', allMusicModelSongs);
       for(int i=0;i<allMusicModelSongs.length;i++){
musicDB.put(allMusicModelSongs[i].id,allMusicModelSongs);
}
  
  await getAllAudiosFromDB();
}

Future<void> getAllAudiosFromDB() async {
  allAudioListFromDB.clear();
  if (musicDB.isEmpty) {
    return;
  }

// allAudioListFromDB = musicDB.get('all_songs')!;
   for(int i=0;i<allMusicModelSongs.length;i++){
    allAudioListFromDB = musicDB.get(allMusicModelSongs[i].id)!;}

  allAudioListFromDB.sort(
    (a, b) => a.musicName!.compareTo(b.musicName!),
  );
}


//----------- Get All Music From DB - End -----------------------------









// ------------- Add To Liked Screen - Start ---------------------


Future<void> addLikedToDB(String id) async {
  if (likedListTemp.contains(id)) {
    return;
  } else {
    likedListTemp.add(id);
    await likedSongeDB.put("favourite", likedListTemp);
     getAllLikedDB();
    
  }
}

Future<void> getAllLikedDB() async {
  if (likedSongeDB.isEmpty) {
    return;
  }
  likedListTemp = likedSongeDB.get("favourite")!;
  await getLikedAudios(likedListTemp);
  likedListFromNotifier.notifyListeners();
}

Future<void> getLikedAudios(List<String> likedList) async {
  likedListFromNotifier.value = allAudioListFromDB.where((element) {
    return likedList.contains(element.id);
  }).toList();
  likedListFromNotifier.value.sort(
    (a, b) => a.musicName!.compareTo(b.musicName!),
  );
  
}

Future<void> likedRemove(String id) async {
  likedListTemp.remove(id);
  await likedSongeDB.put("favourite", likedListTemp);
  await getLikedAudios(likedListTemp);
  await getAllLikedDB();
}


// ------------- Add To Liked Screen - End-----------------


// ------------- Add To Playlist Screen - Start -----------------

ValueNotifier<List<dynamic>> playlistAddList = ValueNotifier([]);


Future<void> playListUpdate() async {
  playlistAddList.value.clear();
  final allkey1 = playlistDB.keys.toList();
  playlistAddList.value = allkey1;
  
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
  playlistSongsFromDB.value.sort(
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

Future<void> renamePlalistfunction(String playlistname, String newplaylistname) async {
  if (newplaylistname == "") {
    return;
  }
  List<String>? tempList = playlistDB.get(playlistname);
  tempList ??= [];
  await playlistDB.put(newplaylistname, tempList);
  await playlistDelete(playlistname);
  await playListUpdate();
}


// ------------- Add To Playlist Screen - End-----------------
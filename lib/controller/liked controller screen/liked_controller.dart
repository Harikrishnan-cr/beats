



import 'package:beat/database/model/music_model.dart';
import 'package:beat/main.dart';
import 'package:beat/view/splash%20screen/splash_screen.dart';
import 'package:beat/widget%20functions/widget_functions.dart';
import 'package:get/get.dart';
 final RxList<MyMusicModel> likedListGetX = <MyMusicModel>[].obs;

class LikedScreenController extends GetxController{
  

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
  }

  Future<void> getLikedAudios(List<String> likedList) async {
    likedListGetX.value = allAudioListFromDB.where((element) {
      return likedList.contains(element.id);
    }).toList();
    likedListGetX.sort(
      (a, b) => a.musicName!.compareTo(b.musicName!),
    );
  }

  Future<void> likedRemove(String id) async {
    likedListTemp.remove(id);
    await likedSongeDB.put("favourite", likedListTemp);
    await getLikedAudios(likedListTemp);
    await getAllLikedDB();
  }
}
import 'package:beat/database/model/music_model.dart';
import 'package:beat/view/splash%20screen/splash_screen.dart';
import 'package:get/get.dart';

class SearchScreenController extends GetxController {
  List<MyMusicModel> musicSearch = [];

  void musicListFunction(String value) {
    musicSearch = allAudioListFromDB
        .where((element) =>
            element.musicName!.toLowerCase().contains(value.toLowerCase()))
        .toList();
    update();
  }

  void close() {
    musicSearch = allAudioListFromDB;
    update();
  }

  @override
  void onInit() {
    musicSearch = allAudioListFromDB;
    super.onInit();
  }
}

import 'dart:collection';
import 'dart:developer';

import 'package:beat/controller/liked%20controller%20screen/liked_controller.dart';
import 'package:beat/database/model/music_model.dart';
import 'package:beat/main.dart';
import 'package:beat/music%20functions/play_audio_function.dart';
import 'package:beat/view/Home%20screen/tab_screen_home.dart';
import 'package:beat/view/splash%20screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashController extends GetxController {

  LikedScreenController likedScreenController = Get.put(LikedScreenController());
  static const musicChanel = MethodChannel('beats');

  Future<void> gotoHome(BuildContext context, {bool mounted = true}) async {
    try {
      if (await Permission.storage.request().isGranted) {
        await getAllAudios();
        if (!mounted) return;
        await Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (ctx) {
            return TabHomeScreen();
          }),
        );
      } else {
        await Permission.storage.request();
        if (await Permission.storage.request().isGranted) {
          await getAllAudios();
          if (!mounted) return;
          await Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (ctx) {
              return TabHomeScreen();
            }),
          );
        } else {
          log('Storage Permission denied');
        }
      }
    } catch (e) {
      log("permission denied");
    }
  }

  Future getAllAudios() async {
 
    final music = await musicChanel.invokeMethod<List<Object?>>('getMusicData');
    for (int i = 0; i < music!.length; i++) {
      final musicModelaudio = MyMusicModel.fromJson(
          HashMap.from(music[i] as Map<dynamic, dynamic>));
      allMusicModelSongs.add(musicModelaudio);
    }

    await addAudiosToDB();
    await createAudiosFileList(allAudioListFromDB);
    await likedScreenController.getAllLikedDB();
  }

  Future<void> addAudiosToDB() async {
// await musicDB.put('all_songs', allMusicModelSongs);
    for (int i = 0; i < allMusicModelSongs.length; i++) {
      musicDB.put(allMusicModelSongs[i].id, allMusicModelSongs);
    }

    await getAllAudiosFromDB();
  }

  Future<void> getAllAudiosFromDB() async {
    allAudioListFromDB.clear();
    if (musicDB.isEmpty) {
      return;
    }

// allAudioListFromDB = musicDB.get('all_songs')!;
    for (int i = 0; i < allMusicModelSongs.length; i++) {
      allAudioListFromDB = musicDB.get(allMusicModelSongs[i].id)!;
    }

    allAudioListFromDB.sort(
      (a, b) => a.musicName!.compareTo(b.musicName!),
    );
  }
}

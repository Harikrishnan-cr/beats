

import 'dart:collection';
import 'dart:developer';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:beat/database/functions/database_function.dart';
import 'package:beat/database/model/music_model.dart';

import 'package:beat/music%20functions/play_audio_function.dart';
import 'package:beat/screens/Home%20screen/tab_screen_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';


final audioPlayer = AssetsAudioPlayer.withId("0");
List<MyMusicModel> allAudioListFromDB = [];

List<Map<dynamic, dynamic>> allSongs = [];

List<MyMusicModel> allMusicModelSongs = [];

List<Audio> audioSongsList = [];

ValueNotifier<List<MyMusicModel>> likedListFromNotifier = ValueNotifier([]);

ValueNotifier<List<MyMusicModel>> playlistSongsFromDB = ValueNotifier([]);

List<String> tempPlaylistId = [];

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({Key? key}) : super(key: key);

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  // static const audioChannel = MethodChannel("audio");
  static const musicChanel = MethodChannel('beats');
  @override
  void initState() {
    gotoHome(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 35, 19, 50),
        body: Center(
          child: Image.asset(
            'assets/images/beats-logo.png',
            height: 170,
            width: 170,
          ),
        ));
  }

//Storage permission
  Future<void> gotoHome(BuildContext context, {bool mounted = true}) async {
    try {
      if (await Permission.storage.request().isGranted) {
        await getAllAudios();
        if (!mounted) return;
        await Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (ctx) {
            return const TabHomeScreen();
          }),
        );
      } else {
        await Permission.storage.request();
        if (await Permission.storage.request().isGranted) {
          await getAllAudios();
          if (!mounted) return;
          await Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (ctx) {
              return const TabHomeScreen();
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
    // final audios = await audioChannel.invokeMethod<List<Object?>>("getAudios");
    final music = await musicChanel.invokeMethod<List<Object?>>('getMusicData');
    for (int i = 0; i < music!.length; i++) {
      final musicModelaudio =
          MyMusicModel.fromJson(HashMap.from(music[i] as Map<dynamic, dynamic>));
      allMusicModelSongs.add(musicModelaudio);
    }

    await addAudiosToDB();
    await createAudiosFileList(allAudioListFromDB);
    await getAllLikedDB();
  }
}


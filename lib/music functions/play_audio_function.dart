

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:beat/database/model/music_model.dart';
import 'package:beat/screens/splash%20screen/splash_screen.dart';
import 'package:beat/widget%20functions/widget_functions.dart';

Future<void> createAudiosFileList(List<MyMusicModel> audioConvertList) async {
  audioSongsList.clear();
  for (int i = 0; i < audioConvertList.length; i++) {
    audioSongsList.add(
      Audio.file(
        audioConvertList[i].audio.toString(),
        metas: Metas(
          id: audioConvertList[i].id.toString(),
          title: audioConvertList[i].musicName.toString(),
          artist: audioConvertList[i].musicArtist.toString(),
          image: const MetasImage.asset('assets/images/beats-png.png'),
        ),
      ),
    );
  }
  await setupPlaylist();
}


Future<void> setupPlaylist() async {
  await audioPlayer.open(Playlist(audios: audioSongsList),   
      autoStart: false,
      loopMode: LoopMode.playlist,
      showNotification: notification.value,
      notificationSettings: const NotificationSettings(stopEnabled: false));
}
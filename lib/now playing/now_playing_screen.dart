// ignore_for_file: unnecessary_null_comparison

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:beat/screens/splash%20screen/splash_screen.dart';
import 'package:beat/widget%20functions/widget_functions.dart';

import 'package:flutter/material.dart';

import 'package:marquee/marquee.dart';


RealtimePlayingInfos? realtimePlayingInfosPlayMusicScreen;
ValueNotifier<bool> loopButton = ValueNotifier(true);
bool nextSongIssue = true;

class PlayMusicScreen extends StatefulWidget {
  const PlayMusicScreen({Key? key}) : super(key: key);

  @override
  State<PlayMusicScreen> createState() => _PlayMusicScreenState();
}

class _PlayMusicScreenState extends State<PlayMusicScreen> {
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: screenHeight * 0.12,
        centerTitle: true,
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 1),
          child: Text('Now Playing'),
        ),
        titleTextStyle: TextStyle(
            fontWeight: FontWeight.w600, fontSize: screenWidth * 0.088),
        backgroundColor: const Color.fromARGB(255, 36, 19, 60),
        elevation: 0,
      ),
      body: audioPlayer.builderRealtimePlayingInfos(
        builder: (context, realtimePlayingInfos) {
          if (realtimePlayingInfos != null) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  musicImage(realtimePlayingInfos),
                  SizedBox(
                    height: screenHeight * 0.015,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.003,
                        horizontal: screenWidth * 0.1),
                    child: musicTitle(realtimePlayingInfos),
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  musicArtist(realtimePlayingInfos),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  likedIconMusic(realtimePlayingInfos),
                  slider(realtimePlayingInfos),
                  timeStamps(realtimePlayingInfos),
                  musicControl(realtimePlayingInfos)
                ],
              ),
            );
          } else {
            return Column(
              children: const [Text('No Music')],
            );
          }
        },
      ),
    );
  }

  Widget musicImage(RealtimePlayingInfos realtimePlayingInfos) {
    return SizedBox(
        height: screenHeight * 0.355,
        width: screenWidth * 0.699,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(45),
            child: Image.asset(
              'assets/images/music-open.png',
              fit: BoxFit.cover,
            )));
  }

  Widget musicTitle(RealtimePlayingInfos realtimePlayingInfos) {
    return SizedBox(
      height: screenHeight * 0.037,
      child: Marquee(
        blankSpace: 60,
        velocity: 60,
        startAfter: const Duration(seconds: 3),
        text: realtimePlayingInfos.current!.audio.audio.metas.title.toString(),
        style: TextStyle(
            color: Colors.white,
            fontSize: screenHeight * 0.032,
            fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget musicArtist(RealtimePlayingInfos realtimePlayingInfos) {
    return Text(
      realtimePlayingInfos.current!.audio.audio.metas.artist.toString(),
      style: const TextStyle(
          color: Color.fromARGB(135, 255, 255, 255), fontSize: 16),
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget likedIconMusic(RealtimePlayingInfos realtimePlayingInfos) {
    return likedListTemp.contains(
            realtimePlayingInfos.current!.audio.audio.metas.id.toString())
        ? favarateIcon(
            favbutton: true,
            id: realtimePlayingInfos.current!.audio.audio.metas.id.toString())
        : favarateIcon(
            favbutton: false,
            id: realtimePlayingInfos.current!.audio.audio.metas.id.toString());
  }

  Widget slider(RealtimePlayingInfos realtimePlayingInfos) {
    return Stack(
      children: [
        SliderTheme(
          data: const SliderThemeData(
            thumbColor: Colors.white,
            activeTrackColor: Colors.white,
            inactiveTrackColor: Color.fromARGB(65, 222, 222, 222),
          ),
          child: Slider.adaptive(
            value: realtimePlayingInfos.currentPosition.inSeconds.toDouble(),
            max: realtimePlayingInfos.duration.inSeconds.toDouble() + 3,
            min: -3,
            onChanged: ((value) {
              if (value <= 0) {
                audioPlayer.seek(const Duration(seconds: 0));
              } else if (value >= realtimePlayingInfos.duration.inSeconds) {
                audioPlayer.seek(realtimePlayingInfos.duration);
              } else {
                audioPlayer.seek(Duration(seconds: value.toInt()));
              }
            }),
          ),
        ),
      ],
    );
  }

  Widget timeStamps(RealtimePlayingInfos realtimePlayingInfos) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            transformString(realtimePlayingInfos.currentPosition.inSeconds),
            style: const TextStyle(color: Colors.grey),
          ),
          SizedBox(
            width: screenWidth * 0.7,
          ),
          Text(
            transformString(realtimePlayingInfos.duration.inSeconds),
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  String transformString(int seconds) {
    String minuteString =
        '${(seconds / 60).floor() < 10 ? 0 : ''}${(seconds / 60).floor()}';
    String secondString = '${seconds % 60 < 10 ? 0 : ''}${seconds % 60}';
    return '$minuteString:$secondString';
  }

  Widget musicControl(RealtimePlayingInfos realtimePlayingInfos) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 65, vertical: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () async {
                  if (nextSongIssue) {
                    nextSongIssue = false;
                    await audioPlayer.previous();
                    nextSongIssue = true;
                  }
                },
                child: const Icon(
                  Icons.skip_previous_rounded,
                  size: 45,
                  color: Colors.white,
                ),
              ),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  audioPlayer.playOrPause();
                },
                child: realtimePlayingInfos.isPlaying
                    ? const Icon(
                        Icons.pause_circle_filled,
                        size: 45,
                        color: Colors.white,
                      )
                    : const Icon(
                        Icons.play_circle_fill,
                        size: 45,
                        color: Colors.white,
                      ),
              ),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () async {
                  if (nextSongIssue) {
                    nextSongIssue = false;
                    await audioPlayer.next();
                    nextSongIssue = true;
                  }
                },
                child: const Icon(
                  Icons.skip_next_rounded,
                  size: 45,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            IconButton(onPressed: () {
              if(loopButton.value){
                audioPlayer.setLoopMode(LoopMode.single);
                loopButton.value = false;
              }else{
                    audioPlayer.setLoopMode(LoopMode.none);
                loopButton.value = true;
              }
            }, icon:ValueListenableBuilder(valueListenable: loopButton, builder: (context, value, child) {
              return loopButton.value ? const Icon(Icons.repeat,color: Colors.white,size: 25,) :  const Icon(Icons.repeat_one,color:Color.fromARGB(255, 149, 6, 175),size: 28,);
            },) ),
              IconButton(
                  onPressed: (() {
                    addToPlayList(context,
                        playId: realtimePlayingInfos
                            .current!.audio.audio.metas.id
                            .toString());
                  }),
                  icon: const Icon(
                    Icons.playlist_add,
                    color: Colors.white,
                    size: 25,
                  ))
            ],
          ),
        )
      ],
    );
  }
}

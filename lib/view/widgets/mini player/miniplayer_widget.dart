


import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:beat/view/now%20playing/now_playing_screen.dart';
import 'package:beat/view/splash%20screen/splash_screen.dart';
import 'package:beat/widget%20functions/widget_functions.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

Widget functionMiniPlayer(BuildContext context) {
  return audioPlayer.builderRealtimePlayingInfos(
      builder: (context, realtimePlayingInfos) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return PlayMusicScreen();
        }));
      },
      child: Visibility(
        visible: miniPlayerVisibility.value,
        child: Container(
          decoration: BoxDecoration(
              // color: Colors.black,
              color: Color.fromARGB(184, 118, 65, 153),
              borderRadius: BorderRadius.circular(14)),
          // color: Colors.yellow,
          height: 75,
          // color: Colors.amber,
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.asset(
                  'assets/images/music-open.png',
                  fit: BoxFit.cover,
                  height: 78,
                  width: 78,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                        child: Marquee(
                          blankSpace: 60,
                          velocity: 30,
                          startAfter: Duration(seconds: 3),
                          text: realtimePlayingInfos
                              .current!.audio.audio.metas.title
                              .toString(),
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () async {
                      if (nextSongIssue) {
                        nextSongIssue = false;
                        await audioPlayer.previous();
                        nextSongIssue = true;
                      }
                    },
                    icon: const Icon(
                      Icons.skip_previous,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        audioPlayer.playOrPause();
                      },
                      icon: realtimePlayingInfos.isPlaying
                          ? const Icon(
                              Icons.pause,
                              size: 40,
                              color: Colors.white,
                            )
                          : const Icon(
                              Icons.play_arrow_rounded,
                              size: 40,
                              color: Colors.white,
                            )),
                  IconButton(
                    onPressed: () async {
                      if (nextSongIssue) {
                        nextSongIssue = false;
                        await audioPlayer.next();
                        nextSongIssue = true;
                      }
                    },
                    icon: const Icon(
                      Icons.skip_next,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
      ),
    );
  });
}
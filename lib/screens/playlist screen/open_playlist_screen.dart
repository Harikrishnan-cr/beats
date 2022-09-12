// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'package:beat/music%20functions/play_audio_function.dart';
import 'package:beat/now%20playing/now_playing_screen.dart';
import 'package:beat/screens/splash%20screen/splash_screen.dart';
import 'package:beat/widget%20functions/widget_functions.dart';
import 'package:flutter/material.dart';

class OpenPlayListScreen extends StatelessWidget {
  String playListName;
  OpenPlayListScreen({Key? key, required this.playListName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(184, 118, 65, 153),
          onPressed: () => showModalBottomSheet(
            backgroundColor: Colors.transparent,
            context: context,
            builder: (context) {
              return buildshet(context, playListName);
            },
          ),
          child: const Icon(Icons.queue_music_outlined),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: functionMiniPlayer(context),
        ),
        appBar: AppBar(
          // actions: [
          //   IconButton(onPressed: () =>showModalBottomSheet(
          //     backgroundColor: Colors.transparent,
          //     context: context, builder: (context) {
          //    return buildshet(context,playListName);
          //   },), icon: const Icon(Icons.add_box,size: 38,color: Color.fromARGB(184, 118, 65, 153),))
          // ],
          backgroundColor: const Color.fromARGB(255, 36, 19, 60),
          toolbarHeight: 90,
          elevation: 0,
          centerTitle: true,
          title: Text(
            playListName,
            style: const TextStyle(
                fontSize: 30,
                letterSpacing: 1.3,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
        body: ValueListenableBuilder(
          valueListenable: playlistSongsFromDB,
          builder: (context, value, child) {
            return ListView.separated(
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemCount: playlistSongsFromDB.value.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () async {
                    await createAudiosFileList(playlistSongsFromDB.value);

                    await audioPlayer.playlistPlayAtIndex(index);

                    await Navigator.of(context)
                        .push(MaterialPageRoute(builder: (ctx1) {
                      return const PlayMusicScreen();
                    }));

                    miniPlayerVisibility.value = true;
                  },
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image.asset(
                      'assets/images/music (3).png',
                      fit: BoxFit.cover,
                      width: 48,
                    ),
                  ),
                  title: Text(
                    playlistSongsFromDB.value[index].musicName.toString(),
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 185,
                        child: Text(
                          playlistSongsFromDB.value[index].musicArtist
                              .toString(),
                          style: const TextStyle(
                              color: Color.fromARGB(135, 255, 255, 255),
                              overflow: TextOverflow.ellipsis,
                              fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  trailing: openplaylistOptionFunction(
                    musicId: playlistSongsFromDB.value[index].id,
                    playNameid: playListName,
                    musicName:
                        playlistSongsFromDB.value[index].musicName.toString(),
                    artistName:
                        playlistSongsFromDB.value[index].musicArtist.toString(),
                    context: context,
                  ),
                );
              },
            );
          },
        ));
  }
}

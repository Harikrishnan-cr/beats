

import 'package:beat/database/functions/database_function.dart';
import 'package:beat/screens/playlist%20screen/open_playlist_screen.dart';
import 'package:beat/widget%20functions/widget_functions.dart';
import 'package:flutter/material.dart';


class PlaylistScreen extends StatelessWidget {
  const PlaylistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    playListUpdate();

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(184, 118, 65, 153),
          onPressed: () {
            createPlayList(context);
          },
          child: const Icon(
            Icons.playlist_add,
            color: Colors.black,
          ),
        ),
        body: ValueListenableBuilder(
            valueListenable: playlistAddList,
            builder: (context, value, child) {
              return playlistAddList.value.isEmpty
                  ? const Center(
                      child: Text(
                        'Create Your Playlist',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 25),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.separated(
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 5,
                            );
                          },
                          itemCount: playlistAddList.value.length,
                          itemBuilder: (context, index) {
                            return Card(
                              color: const Color.fromARGB(184, 118, 65, 153),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              child: ListTile(
                                  onTap: () {
                                    getPlaylistSongs(
                                        playlistAddList.value[index].toString());
                                    playListUpdate();

                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) {
                                        return OpenPlayListScreen(
                                            playListName:
                                                playlistAddList.value[index].toString());
                                      },
                                    ));
                                  },
                                  title: Text(
                                    playlistAddList.value[index].toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 20),
                                  ),
                                  trailing: playlistOptionFunction(
                                      playNameid:
                                          playlistAddList.value[index].toString(),
                                      context: context)),
                            );
                          }));
            }));
  }
}
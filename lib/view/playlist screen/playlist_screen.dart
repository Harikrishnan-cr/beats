

import 'package:beat/controller/playlist%20controller%20screen/playlist_controller.dart';
import 'package:beat/view/playlist%20screen/open_playlist_screen.dart';
import 'package:beat/widget%20functions/widget_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class PlaylistScreen extends StatelessWidget {
   PlaylistScreen({Key? key}) : super(key: key);
final PlaylistController playlistController = Get.put(PlaylistController());
  @override
  Widget build(BuildContext context) {
    playlistController.playListUpdate();
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    

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
        body: Obx(
          
             () {
              return playlistAddList.isEmpty
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
                          itemCount: playlistAddList.length,
                          itemBuilder: (context, index) {
                            return Card(
                              color: const Color.fromARGB(184, 118, 65, 153),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              child: ListTile(
                                  onTap: () {
                                    playlistController.getPlaylistSongs(
                                        playlistAddList[index].toString());
                                    playlistController.playListUpdate();

                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) {
                                        return OpenPlayListScreen(
                                            playListName:
                                                playlistAddList[index].toString());
                                      },
                                    ));
                                  },
                                  title: Text(
                                    playlistAddList[index].toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 20),
                                  ),
                                  trailing: playlistOptionFunction(
                                      playNameid:
                                          playlistAddList[index].toString(),
                                      context: context)),
                            );
                          }));
            }));
  }
}
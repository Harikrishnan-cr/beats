// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:beat/database/functions/database_function.dart';
import 'package:beat/main.dart';
import 'package:beat/now%20playing/now_playing_screen.dart';
import 'package:beat/screens/splash%20screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:marquee/marquee.dart';

ValueNotifier<bool> notification = ValueNotifier(true);

late bool islikednotifie;

List<String> likedListTemp = [];

double screenHeight = 0;
double screenWidth = 0;

ValueNotifier<bool> miniPlayerVisibility = ValueNotifier(false);

// --------- basic colours in app - start -------------------------

Color canvasColor = const Color.fromARGB(255, 36, 19, 60);
Color secondaryColour = const Color.fromARGB(184, 118, 65, 153);
Color redColour = const Color.fromARGB(200, 241, 6, 6);
Color blackColour = const Color.fromARGB(219, 0, 0, 0);
Color greencolour = const Color.fromARGB(200, 32, 224, 7);

// --------- basic colours in app -end -------------------------

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

// ------------------- Add to Playlis ----------------------------------------------

Future addToPlayList(
  ctx, {
  String? playId,
}) {
  return showDialog(
    context: (ctx),
    builder: (context) {
      return ValueListenableBuilder(
          valueListenable: playlistAddList,
          builder: (context, value, _) {
            return AlertDialog(
              elevation: 4,
              backgroundColor: const Color.fromARGB(169, 0, 0, 0),
              title: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Add to playlist',
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                      height: 100.0,
                      width: 300.0,
                      child: playlistAddList.value.isEmpty
                          ? TextButton(
                              onPressed: () {},
                              child: Text(
                                'Create a new playlist',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ))
                          : ListView.builder(
                              itemCount: playlistAddList.value.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                    title: TextButton(
                                        onPressed: () async {
                                          if (tempPlaylistId.contains(playId)) {
                                            Navigator.pop(context);
                                            return snackBar(
                                                "Song already added to playlists",
                                                context,
                                                Colors.black);
                                          } else {
                                            addtoPlaylistSongs(
                                                playId.toString(),
                                                playlistAddList.value[index]
                                                    .toString());

                                            Navigator.pop(context);
                                            return snackBar(
                                                "Song added to Playlist ${playlistAddList.value[index].toString()}",
                                                context,
                                                Colors.black);
                                          }
                                        },
                                        child: Text(
                                            playlistAddList.value[index]
                                                .toString(),
                                            style: TextStyle(
                                                color: Colors.white))));
                              },
                            )),
                  const Divider(
                    thickness: 1.5,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () async {
                            await createPlayList(ctx);
                            Navigator.of(ctx).pop();
                          },
                          child: const Text(
                            'Create Playlist',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                fontSize: 18),
                          )),
                      IconButton(
                          onPressed: () async {
                            await createPlayList(ctx);
                            Navigator.of(ctx).pop();
                          },
                          icon: const Icon(
                            Icons.playlist_add,
                            color: Colors.white,
                            size: 27,
                          ))
                    ],
                  )
                ],
              ),
            );
          });
    },
  );
}

//---------------- End (Add to Playlis) -------------------------------------------

// ------------------ Create Playlist --------------------------------
TextEditingController playlistNameController = TextEditingController();
createPlayList(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        elevation: 4,
        backgroundColor: const Color.fromARGB(221, 0, 0, 0),
        title: Column(
          children: const [
            Text(
              'New Playlist',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: Colors.white),
            ),
            SizedBox(
              height: 15,
            ),
            Text('Enter the name of new playlist',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.white)),
            SizedBox(
              height: 10,
            ),
            Divider(
              thickness: 1.5,
              color: Colors.white,
            )
          ],
        ),
        content: TextField(
          controller: playlistNameController,
          style: const TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none),
              hintText: 'New Playlist',
              filled: true,
              fillColor: const Color.fromARGB(217, 217, 217, 217),
              hintStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(153, 0, 0, 0),
                  fontSize: 16)),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: (() {
                    Navigator.of(context).pop();
                  }),
                  child: const Text(
                    'cancel',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.red,
                        fontSize: 18),
                  ),
                ),
                TextButton(
                  onPressed: (() {
                    if (playlistNameController.text.isEmpty) {
                      return;
                    } else if (playlistDB
                        .containsKey(playlistNameController.text.toString())) {
                      snackBar('Failed: Playlist already exists', context,
                          redColour);
                      playlistNameController.clear();
                      Navigator.of(context).pop();
                    } else {
                      playlistCreation(playlistNameController.text);
                      playListUpdate();
                      playlistNameController.clear();
                      Navigator.of(context).pop();
                    }
                  }),
                  child: const Text(
                    'create',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.green,
                        fontSize: 18),
                  ),
                )
              ],
            ),
          )
        ],
      );
    },
  );
}

// ---------------- End (Create Playlist) -------------------------

// ---------------------- Options -----------------------------------

Widget myMusicOptionFunction(String id, context) {
  return PopupMenuButton(
    position: PopupMenuPosition.under,
    elevation: 0,
    onSelected: (value) {
      if (value == MyListMenu.item1) {
        if (likedListTemp.contains(id)) {
          likedRemove(id);
          favarateIcon(
            favbutton: false,
          );
          snackBar('Remove from to Liked', context, Colors.red);
        } else {
          addLikedToDB(id);
          snackBar('Add to liked', context, Colors.green);
          favarateIcon(favbutton: true);
        }
      } else if (value == MyListMenu.item2) {
        addToPlayList(context, playId: id);
      } else if (value == MyListMenu.item3) {}
    },
    icon: const Icon(
      Icons.more_vert,
      color: Colors.white,
      size: 20,
    ),
    color: const Color.fromARGB(255, 118, 65, 153),
    itemBuilder: (context) => [
      PopupMenuItem(
          value: MyListMenu.item1,
          textStyle: TextStyle(
              fontWeight: FontWeight.w500, color: Colors.black, fontSize: 17),
          child: Text(likedListTemp.contains(id)
              ? 'Remove From Liked'
              : 'Add To Liked')),
      const PopupMenuItem(
          value: MyListMenu.item2,
          textStyle: TextStyle(
              fontWeight: FontWeight.w500, color: Colors.black, fontSize: 17),
          child: Text('Add To Playlist')),
      const PopupMenuItem(
          value: MyListMenu.item3,
          textStyle: TextStyle(
              fontWeight: FontWeight.w500, color: Colors.black, fontSize: 17),
          child: Text('Info')),
    ],
  );
}

enum MyListMenu {
  item1,
  item2,
  item3,
}

//---------------------Options end----------------------------------------

void snackBar(String content, BuildContext context, Color displayColour) {
  final snackBar = SnackBar(
    content: Text(content),
    duration: Duration(seconds: 1),
    backgroundColor: displayColour,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

//-----------------------Favarate button -------------------------

Widget favarateIcon({bool? favbutton, id}) {
  return SizedBox(
    width: 45,
    child: LikeButton(
      likeBuilder: (islike) {
        if (!islike) {
          likedRemove(id);
        } else {
          addLikedToDB(id);
        }
        return null;
      },
      size: 35,
      isLiked: favbutton,
      animationDuration: const Duration(),
    ),
  );
}

// --------------------- Playlist Options - start ---------------------

Widget playlistOptionFunction({String? playNameid, context}) {
  return PopupMenuButton(
    position: PopupMenuPosition.under,
    elevation: 0,
    onSelected: (value) async {
      if (value == PlayListMenu.item1) {
        await renamPlayList(context, playNameid.toString());
        snackBar('playlist Updated successfully', context, greencolour);
      } else if (value == PlayListMenu.item2) {
        await playlistDelete(playNameid.toString());
        snackBar('playlist deleted successfully', context, redColour);
      } else if (value == PlayListMenu.item3) {}
    },
    icon: const Icon(
      Icons.more_vert,
      color: Colors.white,
      size: 20,
    ),
    color: const Color.fromARGB(255, 118, 65, 153),
    itemBuilder: (context) => [
      PopupMenuItem(
          value: PlayListMenu.item1,
          textStyle: TextStyle(
              fontWeight: FontWeight.w500, color: Colors.black, fontSize: 17),
          child: Text('Rename')),
      const PopupMenuItem(
          value: PlayListMenu.item2,
          textStyle: TextStyle(
              fontWeight: FontWeight.w500, color: Colors.black, fontSize: 17),
          child: Text('Delete')),
      const PopupMenuItem(
          value: PlayListMenu.item3,
          textStyle: TextStyle(
              fontWeight: FontWeight.w500, color: Colors.black, fontSize: 17),
          child: Text('Info')),
    ],
  );
}

enum PlayListMenu {
  item1,
  item2,
  item3,
}

//----------------------Open PlayList Options - starts ---------------------------//

Widget openplaylistOptionFunction(
    {String? playNameid, context, String? musicId}) {
  return PopupMenuButton(
    position: PopupMenuPosition.under,
    elevation: 0,
    onSelected: (value) {
      if (value == OpenPlayListMenu.item1) {
        if (likedListTemp.contains(musicId)) {
          likedRemove(musicId.toString());
          favarateIcon(
            favbutton: false,
          );
          snackBar('Remove from to Liked', context, Colors.red);
        } else {
          addLikedToDB(musicId.toString());
          snackBar('Add to liked', context, Colors.green);
          favarateIcon(favbutton: true);
        }
      } else if (value == OpenPlayListMenu.item2) {
        playlistSongDelete(musicId.toString(), playNameid.toString());
      } else if (value == OpenPlayListMenu.item3) {}
    },
    icon: const Icon(
      Icons.more_vert,
      color: Colors.white,
      size: 20,
    ),
    color: const Color.fromARGB(255, 118, 65, 153),
    itemBuilder: (context) => [
      PopupMenuItem(
          value: OpenPlayListMenu.item1,
          textStyle: TextStyle(
              fontWeight: FontWeight.w500, color: Colors.black, fontSize: 17),
          child: Text(likedListTemp.contains(musicId)
              ? 'Remove From Liked'
              : 'Add To Liked')),
      const PopupMenuItem(
          value: OpenPlayListMenu.item2,
          textStyle: TextStyle(
              fontWeight: FontWeight.w500, color: Colors.black, fontSize: 17),
          child: Text('Remove From Playlist')),
      const PopupMenuItem(
          value: OpenPlayListMenu.item3,
          textStyle: TextStyle(
              fontWeight: FontWeight.w500, color: Colors.black, fontSize: 17),
          child: Text('Info')),
    ],
  );
}

enum OpenPlayListMenu {
  item1,
  item2,
  item3,
}

//----------------------Open PlayList Options - Ends ---------------------------//

//------------------------Reaname Playlist - start ---------------------------

TextEditingController renamePlalisttNameController = TextEditingController();

renamPlayList(BuildContext context, String currentName) {
  renamePlalisttNameController.text = currentName;
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        elevation: 4,
        backgroundColor: const Color.fromARGB(221, 0, 0, 0),
        title: Column(
          children: const [
            Text(
              'Rename Playlist',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: Colors.white),
            ),
            SizedBox(
              height: 15,
            ),
            Text('Edit the name of playlist',
                style: TextStyle(
                    // fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Colors.white)),
            SizedBox(
              height: 10,
            ),
            Divider(
              thickness: 1.5,
              color: Colors.white,
            )
          ],
        ),
        content: TextField(
          controller: renamePlalisttNameController,
          style: const TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none),
              hintText: currentName,
              filled: true,
              fillColor: const Color.fromARGB(217, 217, 217, 217),
              hintStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(153, 0, 0, 0),
                  fontSize: 16)),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: (() {
                    Navigator.of(context).pop();
                  }),
                  child: const Text(
                    'cancel',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.red,
                        fontSize: 18),
                  ),
                ),
                TextButton(
                  onPressed: (() {
                    if (renamePlalisttNameController.text.isEmpty) {
                      Navigator.of(context).pop();
                      return;
                    } else if (currentName ==
                        renamePlalisttNameController.text) {
                      Navigator.of(context).pop();
                      return;
                    } else if (playlistDB.containsKey(
                        renamePlalisttNameController.text.toString())) {
                      snackBar('Failed: Playlist already exists', context,
                          redColour);
                      playlistNameController.clear();
                      Navigator.of(context).pop();
                    } else {
                      renamePlalistfunction(
                          currentName, renamePlalisttNameController.text);
                      renamePlalisttNameController.clear();
                      Navigator.of(context).pop();
                    }
                  }),
                  child: const Text(
                    'create',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.green,
                        fontSize: 18),
                  ),
                )
              ],
            ),
          )
        ],
      );
    },
  );
}

//------------------------Reaname Playlist - End ---------------------------

//-------------Add songs from Open Playlist - start --------------------------

Widget buildshet(BuildContext context, String? playlistName) {
  return ValueListenableBuilder(
    valueListenable: playlistSongsFromDB,
    builder: (context, value, child) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              color: blackColour, borderRadius: BorderRadius.circular(20)),
          child: ListView.builder(
            itemCount: allAudioListFromDB.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.asset(
                    'assets/images/music (3).png',
                    fit: BoxFit.cover,
                    width: 48,
                  ),
                ),
                title: SizedBox(
                  width: 140,
                  child: Text(
                    allAudioListFromDB[index].musicName.toString(),
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 160,
                      child: Text(
                        allAudioListFromDB[index].musicArtist.toString(),
                        style: const TextStyle(
                            color: Color.fromARGB(135, 255, 255, 255),
                            overflow: TextOverflow.ellipsis,
                            fontSize: 14),
                      ),
                    ),
                  ],
                ),
                trailing: IconButton(
                  icon: playlistSongsFromDB.value
                          .contains(allAudioListFromDB[index])
                      ? Icon(
                          Icons.remove_circle,
                          size: 35,
                          color: redColour,
                        )
                      : Icon(Icons.add_circle,
                          size: 35, color: Color.fromARGB(200, 32, 224, 7)),
                  onPressed: () async {
                    tempPlaylistId
                            .contains(allAudioListFromDB[index].id.toString())
                        ? await playlistSongDelete(
                            allAudioListFromDB[index].id.toString(),
                            playlistName.toString())
                        : await addtoPlaylistSongs(
                            allAudioListFromDB[index].id.toString(),
                            playlistName.toString());
                    await playListUpdate();
                  },
                ),
              );
            },
          ),
        ),
      );
    },
  );
}


//-------------Add songs from Open Playlist - end --------------------------
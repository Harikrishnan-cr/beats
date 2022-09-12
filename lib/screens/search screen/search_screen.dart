
import 'package:beat/database/model/music_model.dart';
import 'package:beat/music%20functions/play_audio_function.dart';
import 'package:beat/screens/splash%20screen/splash_screen.dart';
import 'package:beat/widget%20functions/widget_functions.dart';

import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<MyMusicModel> musicSearch = List.from(allAudioListFromDB);

  void musicListFunction(String value) {
    setState(() {
      musicSearch = allAudioListFromDB
          .where((element) =>
              element.musicName!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 36, 19, 60),
        title: const Text('Search'),
        titleTextStyle:
            const TextStyle(fontWeight: FontWeight.w900, fontSize: 27),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) => musicListFunction(value),
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(255, 118, 65, 153),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none),
                    hintText: 'Songs,artist or album',
                    hintStyle: const TextStyle(
                        color: Color.fromARGB(117, 255, 255, 255),
                        fontWeight: FontWeight.w500,
                        fontSize: 22),
                    prefixIcon: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.search_rounded),
                      iconSize: 28,
                      color: Colors.white,
                    ),
                  ),
                  cursorColor: Colors.green,
                )),
            const SizedBox(
              height: 20,
            ),
            Expanded(
                child: musicSearch.isEmpty
                    ? const Center(
                        child: Text(
                        'No Result Found',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.white),
                      ))
                    : ListView.separated(
                        separatorBuilder: (context, index) => const Divider(
                              thickness: 5,
                              color: Colors.transparent,
                            ),
                        itemCount: musicSearch.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.asset(
                                  'assets/images/music (3).png',
                                  fit: BoxFit.cover,
                                  width: 48,
                                )),
                            title: SizedBox(
                              height: 18,
                              child: Marquee(
                                velocity: 30,
                                blankSpace: 10,
                                startAfter: const Duration(seconds: 9),
                                text: musicSearch[index].musicName.toString(),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                            subtitle: Text(
                              musicSearch[index].musicArtist.toString(),
                              style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: Color.fromARGB(135, 255, 255, 255),
                                  fontSize: 14),
                            ),
                            trailing: myMusicOptionFunction(
                                musicSearch[index].id.toString(), context,musicName:musicSearch[index].musicName.toString(),artistName: musicSearch[index].musicArtist.toString()),
                            onTap: () async {
                              await createAudiosFileList(allAudioListFromDB);
                              final index1 = allAudioListFromDB.indexWhere(
                                  (element) =>
                                      element.id ==
                                      musicSearch[index].id.toString());

                              if (index1 >= 0) {
                                audioPlayer.playlistPlayAtIndex(index1);

                                miniPlayerVisibility.value = true;
                              }
                            },
                          );
                        })),
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: functionMiniPlayer(context),
      ),
    );
  }
}
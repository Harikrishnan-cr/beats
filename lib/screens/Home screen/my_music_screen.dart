// ignore_for_file: use_build_context_synchronously

import 'package:beat/music%20functions/play_audio_function.dart';
import 'package:beat/now%20playing/now_playing_screen.dart';
import 'package:beat/screens/splash%20screen/splash_screen.dart';
import 'package:beat/widget%20functions/widget_functions.dart';
import 'package:flutter/material.dart';

class MyMusicScreen extends StatefulWidget {
  const MyMusicScreen({Key? key}) : super(key: key);

  @override
  State<MyMusicScreen> createState() => _MyMusicScreenState();
}

class _MyMusicScreenState extends State<MyMusicScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      child: Column(children: [
        ListView.separated(
          separatorBuilder: (context, index) => const Divider(
            thickness: 5,
            color: Colors.transparent,
          ),
          controller: ScrollController(),
          itemBuilder: ((context, index) {
            return ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.asset(
                  'assets/images/music (3).png',
                  fit: BoxFit.cover,
                  width: 48,
                ),
              ),
              title: Text(
                allAudioListFromDB[index].musicName.toString(),
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 185,
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
              trailing: myMusicOptionFunction(
                  allAudioListFromDB[index].id.toString(), context),
              onTap: () async {
                await createAudiosFileList(allAudioListFromDB);
                await audioPlayer.playlistPlayAtIndex(index);

                await Navigator.of(context)
                    .push(MaterialPageRoute(builder: (ctx1) {
                  return const PlayMusicScreen();
                }));
                // if (!mounted) return;
                // await Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) {
                //       return PlayMusicScreen();
                //     },
                //   ),
                // );

                miniPlayerVisibility.value = true;
              },
            );
          }),
          itemCount: allAudioListFromDB.length,
          shrinkWrap: true,
        ),
      ]),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

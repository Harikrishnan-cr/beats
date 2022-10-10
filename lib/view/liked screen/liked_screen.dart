// ignore_for_file: use_build_context_synchronously

import 'package:beat/controller/liked%20controller%20screen/liked_controller.dart';
import 'package:beat/music%20functions/play_audio_function.dart';
import 'package:beat/view/now%20playing/now_playing_screen.dart';
import 'package:beat/view/splash%20screen/splash_screen.dart';
import 'package:beat/widget%20functions/widget_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LikedScreen extends StatelessWidget {
  const LikedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return likedListGetX.isEmpty
            ? const Center(
                child: Text(
                  'Add To Favorites',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 25),
                ),
              )
            : ListView.separated(
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
                      likedListGetX[index].musicName.toString(),
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 185,
                          child: Text(
                            likedListGetX[index].musicName.toString(),
                            style: const TextStyle(
                                color: Color.fromARGB(135, 255, 255, 255),
                                overflow: TextOverflow.ellipsis,
                                fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    trailing: likedListTemp
                            .contains(likedListGetX[index].id.toString())
                        ? favarateIcon(
                            favbutton: true,
                            id: likedListGetX[index].id.toString())
                        : favarateIcon(
                            favbutton: false,
                            id: likedListGetX[index].id.toString(),
                          ),
                    onTap: () async {
                      await createAudiosFileList(likedListGetX);
                      await audioPlayer.playlistPlayAtIndex(index);

                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (ctx1) {
                        return PlayMusicScreen();
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
                itemCount: likedListGetX.length,
                shrinkWrap: true,
              );
      }),
    );
  }
}

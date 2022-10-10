

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:beat/controller/Home%20screen%20controller/home_controller.dart';

import 'package:beat/view/Home%20screen/my_music_screen.dart';
import 'package:beat/view/liked%20screen/liked_screen.dart';
import 'package:beat/view/playlist%20screen/playlist_screen.dart';
import 'package:beat/view/search%20screen/search_screen.dart';
import 'package:beat/view/settings%20screen/settings_screen.dart';
import 'package:beat/view/widgets/mini%20player/miniplayer_widget.dart';


import 'package:flutter/material.dart';
import 'package:get/get.dart';



class TabHomeScreen extends StatelessWidget {
   TabHomeScreen({Key? key}) : super(key: key);

//   @override
//   State<TabHomeScreen> createState() => _TabHomeScreenState();
// }

// class _TabHomeScreenState extends State<TabHomeScreen> {
  // final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();
final HomeController homeController = Get.put(HomeController());
  // @override
  // void initState() {
  //   // ignore: todo
  //   // TODO: implement initState
  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   // ignore: todo
  //   // TODO: implement dispose
  //   audioPlayer.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: WillPopScope(
          onWillPop: () => onBackButtonPresse(context),
          child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 85,
              title: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.5),
                child: Text('BEATS'),
              ),
              titleTextStyle:
                  const TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (ctx1) {
                      return  SearchScreen();
                    }));
                  },
                  icon: const Icon(Icons.search_rounded),
                  iconSize: 30,
                ),
                const SizedBox(
                  width: 5,
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (ctx1) {
                      return const SettingsScreen();
                    }));
                  },
                  icon: const Icon(Icons.settings),
                  iconSize: 30,
                ),
                const SizedBox(
                  width: 20,
                ),
              ],
              backgroundColor: const Color.fromARGB(255, 36, 19, 60),
              elevation: 0,
              bottom: const TabBar(
                  indicatorColor: Colors.transparent,
                  labelStyle:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                  unselectedLabelStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                  tabs: [
                    Tab(
                      text: 'My Music',
                    ),
                    Tab(
                      text: 'Liked',
                    ),
                    Tab(
                      text: 'Playlist',
                    ),
                  ]),
            ),
            body:  TabBarView(
                children: [MyMusicScreen(), LikedScreen(), PlaylistScreen()]),
            bottomNavigationBar: Padding(
                padding: const EdgeInsets.all(8.0),
                child: functionMiniPlayer(context)),
          ),
        ),
      ),
    );
  }


 Future<bool> onBackButtonPresse(BuildContext ctx) async{
   
  bool exitApp = await showDialog(
    context: ctx,
    builder: (context) {
      return AlertDialog(

        title: const Text("Really"),
        content: const Text("Do you want to close the app?"),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text("No",style: TextStyle(color: Colors.blue),)),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
               
              },
              child: const Text("Yes",style: TextStyle(color:Colors.blue)))
        ],
      );
    },
  );
  return exitApp;
}
  
}
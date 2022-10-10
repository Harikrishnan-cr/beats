import 'package:beat/database/model/music_model.dart';
import 'package:beat/view/splash%20screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';


late Box<List<MyMusicModel>> musicDB;
late Box<List<String>> likedSongeDB;
late Box<List<String>> playlistDB;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(MyMusicModelAdapter().typeId)) {
    Hive.registerAdapter(MyMusicModelAdapter());
  }

  musicDB = await Hive.openBox('music_db');
  likedSongeDB = await Hive.openBox('favourite_box');

  playlistDB = await Hive.openBox('playlist_box');

  runApp(const MusicApp());
}

class MusicApp extends StatelessWidget {
  const MusicApp({Key? key}) : super(key: key);

 
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        canvasColor: const Color.fromARGB(255, 36, 19, 60),
      ),
      debugShowCheckedModeBanner: false,
      home:  ScreenSplash(),
    );
  }
}



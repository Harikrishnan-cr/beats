

import 'package:hive_flutter/adapters.dart';
part 'music_model.g.dart'; 

@HiveType(typeId: 1)
class MyMusicModel{
 @HiveField(0)
  String? id;
   @HiveField(1)
  String? audio;
   @HiveField(2)
  String? musicName;
   @HiveField(3)
  String? musicArtist;
  

  MyMusicModel({this.id,this.audio,this.musicName,this.musicArtist});

  MyMusicModel.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    audio = json['audio'];
    musicName = json['musicName'];
    musicArtist = json['musicArtist'];
    
  }
}
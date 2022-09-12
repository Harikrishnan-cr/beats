

class MyMusicModel{

  String? id;
  String? audio;
  String? musicName;
  String? musicArtist;
  

  MyMusicModel({this.id,this.audio,this.musicName,this.musicArtist});

  MyMusicModel.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    audio = json['audio'];
    musicName = json['musicName'];
    musicArtist = json['musicArtist'];
    
  }
}








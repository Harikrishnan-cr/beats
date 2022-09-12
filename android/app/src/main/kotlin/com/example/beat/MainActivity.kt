package com.example.beat

import android.content.*
import android.net.Uri
import android.provider.MediaStore
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel



class MainActivity: FlutterActivity() {
    private val AUDIO_CHANEL = "beats"
    private lateinit var channel: MethodChannel
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger,AUDIO_CHANEL)
        channel.setMethodCallHandler { call, result ->
            if (call.method=="getMusicData"){
                val musicall = getMusicData()
                result.success(musicall)
            }
        }
    }

    fun getMusicData():MutableList<MutableMap<String,String>>{
        val musicall: MutableList<MutableMap<String, String>> = ArrayList()
        val selection = MediaStore.Audio.Media.IS_MUSIC + "!=0"

        val projection = arrayOf(MediaStore.Audio.Media._ID,MediaStore.Audio.Media.TITLE,MediaStore.Audio.Media.DATA,MediaStore.Audio.Media.ARTIST,MediaStore.Audio.Media.DURATION,MediaStore.Audio.Media.ALBUM_ID)
        applicationContext.contentResolver.query(
            MediaStore.Audio.Media.EXTERNAL_CONTENT_URI,projection,selection,null,null
        )?.use { cursor ->
            while (cursor.moveToNext()) {



                val song: MutableMap<String, String> = HashMap()

                song.putAll(setOf("id" to cursor.getString(0),"musicName" to cursor.getString(1),"audio" to cursor.getString(2),"musicArtist" to cursor.getString(3)))
                musicall.add(song)

            }

        }



        return musicall;



    }
}

import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongPlayer extends StatefulWidget {
  const SongPlayer({required this.song, Key? key}) : super(key: key);
  final SongModel song;

  @override
  SongPlayerState createState() => SongPlayerState();
}

class SongPlayerState extends State<SongPlayer> {
  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(),
    );
  }
}

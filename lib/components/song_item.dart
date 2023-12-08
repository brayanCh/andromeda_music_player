import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongItem extends StatelessWidget {
  const SongItem({required this.song, Key? key}) : super(key: key);

  final SongModel song;
  void onTap() {
    print('SongItem: onTap: song: ${song.title} ${song.artist} ${song.album}');
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(song.title),
      subtitle: Text((song.artist ?? 'Unknown Artist') +
          '\n' +
          (song.album ?? 'Unknown Album')),
      isThreeLine: true,
    );
  }
}

import 'package:andromeda_music_player/blocs/current_song/current_song_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongItem extends StatelessWidget {
  const SongItem({required this.song, Key? key}) : super(key: key);

  final SongModel song;

  @override
  Widget build(BuildContext context) {
    final provider = BlocProvider.of<CurrentSongBloc>(context);

    return ListTile(
      onTap: () {
        provider.add(SetNewSong(song));
        provider.add(Interact());
      },
      title: Text(song.title),
      subtitle: Text((song.artist ?? 'Unknown Artist') +
          '\n' +
          (song.album ?? 'Unknown Album')),
      isThreeLine: true,
    );
  }
}

//import 'package:andromeda_music_player/blocs/current_song/current_song_bloc.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AlbumItem extends StatelessWidget {
  const AlbumItem({required this.album, required this.onTap, Key? key})
      : super(key: key);

  final AlbumModel album;
  final dynamic onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: () {
          onTap();
          //context.read<CurrentSongBloc>().add(CurrentSongChanged(song));
        },
        title: Text(album.album),
        subtitle: Text(album.artist ?? 'Unknown Artist'));
  }
}

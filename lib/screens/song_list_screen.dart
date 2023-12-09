import 'package:andromeda_music_player/blocs/music_list/music_list_bloc.dart';
import 'package:andromeda_music_player/components/song_bar.dart';
import 'package:andromeda_music_player/components/song_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SongScreen extends StatefulWidget {
  const SongScreen({Key? key}) : super(key: key);
  @override
  SongScreenState createState() => SongScreenState();
}

enum SongScreenSection {
  artist,
  album,
  song,
}

class SongScreenState extends State<SongScreen> {
  SongScreenSection currentSection = SongScreenSection.album;

  @override
  Widget build(BuildContext context) {
    final provider = BlocProvider.of<MusicListBloc>(context);
    provider.add(ReadLocalDirs());

    return BlocBuilder<MusicListBloc, MusicListState>(
        builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Song Screen' + ' ' + '(${state.musicList.length})'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child:
                  ListView(padding: const EdgeInsets.all(8), children: <Widget>[
                for (var song in state.musicList) SongItem(song: song),
              ]),
            ),
            const SongBar(),
          ],
        ),
      );
    });
  }
}

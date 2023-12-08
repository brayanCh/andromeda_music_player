import 'package:andromeda_music_player/blocs/music_list/music_list_bloc.dart';
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
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(25.0),
              child: SegmentedButton(
                selected: <SongScreenSection>{currentSection},
                segments: const <ButtonSegment<SongScreenSection>>[
                  ButtonSegment<SongScreenSection>(
                    value: SongScreenSection.artist,
                    label: Text('Artist'),
                  ),
                  ButtonSegment<SongScreenSection>(
                    value: SongScreenSection.album,
                    label: Text('Album'),
                  ),
                  ButtonSegment<SongScreenSection>(
                    value: SongScreenSection.song,
                    label: Text('Song'),
                  ),
                ],
                onSelectionChanged: (Set<SongScreenSection> section) {
                  setState(() {
                    currentSection = section.first;
                  });
                },
              ),
            ),
            ListView(
              shrinkWrap: true,
            ),
          ],
        ),
      );
    });
  }
}

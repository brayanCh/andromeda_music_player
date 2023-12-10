import 'package:andromeda_music_player/blocs/music_list/music_list_bloc.dart';
import 'package:andromeda_music_player/components/album_item.dart';
import 'package:andromeda_music_player/components/song_bar.dart';
import 'package:andromeda_music_player/components/song_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AlbumListScreen extends StatefulWidget {
  const AlbumListScreen({Key? key}) : super(key: key);
  @override
  AlbumListScreenState createState() => AlbumListScreenState();
}

enum Section {
  albumSelect,
  insideAlbum,
}

class AlbumListScreenState extends State<AlbumListScreen> {
  Section section = Section.albumSelect;
  AlbumModel? albumSelected;

  onAlbumSelected(AlbumModel album) {
    setState(() {
      section = Section.insideAlbum;
      albumSelected = album;
    });
  }

  List<SongModel> getSongsFromAlbum(AlbumModel? album, List<SongModel> songs) {
    if (album == null) return [];
    List<SongModel> albumSongs =
        songs.where((item) => item.album == album.album).toList();
    albumSongs.sort((a, b) => (a.track ?? 0) - (b.track ?? 0));
    return albumSongs;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MusicListBloc, MusicListState>(
        builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Album Screen (${state.albumList.length})'),
          leading: section == Section.insideAlbum
              ? IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    setState(() {
                      section = Section.albumSelect;
                    });
                  },
                )
              : null,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                child: ListView(
                    padding: const EdgeInsets.all(8),
                    children: (section == Section.insideAlbum)
                        ? <Widget>[
                            for (SongModel song in getSongsFromAlbum(
                                albumSelected, state.musicList))
                              SongItem(song: song)
                          ]
                        : <Widget>[
                            for (AlbumModel album in state.albumList)
                              AlbumItem(
                                  album: album,
                                  onTap: () => onAlbumSelected(album))
                          ])),
            const SongBar(),
          ],
        ),
      );
    });
  }
}

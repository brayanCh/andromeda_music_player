import 'package:andromeda_music_player/blocs/music_list/music_list_bloc.dart';
import 'package:andromeda_music_player/components/album_item.dart';
import 'package:andromeda_music_player/components/song_bar.dart';
import 'package:andromeda_music_player/components/song_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';

class ArtistListScreen extends StatefulWidget {
  const ArtistListScreen({Key? key}) : super(key: key);
  @override
  ArtistListScreenState createState() => ArtistListScreenState();
}

enum Section {
  artistSelect,
  insideArtist,
  insideAlbum,
}

class SwitchSection extends StatelessWidget {
  final Section section;
  final ArtistModel? artistSelected;
  final AlbumModel? albumSelected;
  final Function(ArtistModel) onArtistSelected;
  final Function(AlbumModel) onAlbumSelected;

  const SwitchSection({
    Key? key,
    required this.section,
    required this.onArtistSelected,
    required this.onAlbumSelected,
    required this.artistSelected,
    required this.albumSelected,
  }) : super(key: key);

  List<SongModel> getSongsFromArtist(
      ArtistModel? artist, List<SongModel> songs) {
    if (artist == null) return [];
    List<SongModel> albumSongs =
        songs.where((item) => item.artist == artist.artist).toList();
    //albumSongs.sort((a, b) => (a.track ?? 0) - (b.track ?? 0));
    return albumSongs;
  }

  List<AlbumModel> getAlbumsFromArtist(
      ArtistModel? artist, List<AlbumModel> albums) {
    if (artist == null) return [];
    List<AlbumModel> albumSongs =
        albums.where((item) => item.artist == artist.artist).toList();
    //albumSongs.sort((a, b) => (a.track ?? 0) - (b.track ?? 0));
    return albumSongs;
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
      switch (section) {
        case Section.artistSelect:
          return ListView(padding: const EdgeInsets.all(8), children: <Widget>[
            for (ArtistModel artist in state.artistList) ...[
              ListTile(
                title: Text(artist.artist),
                onTap: () => onArtistSelected(artist),
              ),
            ],
          ]);
        case Section.insideArtist:
          return ListView(padding: const EdgeInsets.all(8), children: <Widget>[
            Container(
                padding: const EdgeInsets.all(8),
                child: const Text('Songs',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ))),
            for (SongModel song
                in getSongsFromArtist(artistSelected, state.musicList)) ...[
              SongItem(song: song)
            ],
            Container(
                padding: const EdgeInsets.all(8),
                child: const Text('Albums',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ))),
            for (AlbumModel album
                in getAlbumsFromArtist(artistSelected, state.albumList)) ...[
              AlbumItem(album: album, onTap: () => onAlbumSelected(album))
            ]
          ]);
        case Section.insideAlbum:
          return ListView(
            padding: const EdgeInsets.all(8),
            children: <Widget>[
              for (SongModel song
                  in getSongsFromAlbum(albumSelected, state.musicList))
                SongItem(song: song)
            ],
          );
      }
    });
  }
}

class ArtistListScreenState extends State<ArtistListScreen> {
  Section section = Section.artistSelect;
  ArtistModel? artistSelected;
  AlbumModel? albumSelected;

  onArtistSelected(ArtistModel artist) {
    setState(() {
      section = Section.insideArtist;
      artistSelected = artist;
    });
  }

  onAlbumSelected(AlbumModel album) {
    setState(() {
      section = Section.insideAlbum;
      albumSelected = album;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Artists Screen'),
        leading: section != Section.artistSelect
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  setState(() {
                    section == Section.insideArtist
                        ? section = Section.artistSelect
                        : section = Section.insideArtist;
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
              child: SwitchSection(
            section: section,
            onArtistSelected: onArtistSelected,
            onAlbumSelected: onAlbumSelected,
            artistSelected: artistSelected,
            albumSelected: albumSelected,
          )),
          const SongBar(),
        ],
      ),
    );
  }
}

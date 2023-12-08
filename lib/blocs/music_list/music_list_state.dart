part of 'music_list_bloc.dart';

enum Status { win, lose, draw, playing }

class MusicListState {
  List<SongModel> musicList;
  List<AlbumModel> albumList;
  List<ArtistModel> artistList;
  List<List<SongModel>> playlist;

  MusicListState({
    this.musicList = const [],
    this.albumList = const [],
    this.artistList = const [],
    this.playlist = const [],
  });

  Future<MusicListState> readLocalMusic({
    List<SongModel>? musicList,
  }) async {
    PermissionStatus readPermission = await Permission.audio.request();
    final OnAudioQuery audioQuery = OnAudioQuery();

    if (readPermission != PermissionStatus.granted) {
      return this;
    }

    List<SongModel> audios = await audioQuery.querySongs();

    if (audios.isEmpty) {
      return this;
    }
    print('audios: ${audios.length} $audios');

    this.musicList = audios;
    return this;
  }

  MusicListState cleanList() {
    musicList = [];
    return this;
  }

  MusicListState copyWith({
    List<SongModel>? musicList,
    List<AlbumModel>? albumList,
    List<ArtistModel>? artistList,
    List<List<SongModel>>? playlist,
  }) {
    return MusicListState(
      musicList: musicList ?? this.musicList,
      albumList: albumList ?? this.albumList,
      artistList: artistList ?? this.artistList,
      playlist: playlist ?? this.playlist,
    );
  }
}

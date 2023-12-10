part of 'music_list_bloc.dart';

class MusicListState extends Equatable {
  final List<SongModel> musicList;
  final List<AlbumModel> albumList;
  final List<ArtistModel> artistList;
  final List<List<SongModel>> playlist;

  const MusicListState({
    this.musicList = const [],
    this.albumList = const [],
    this.artistList = const [],
    this.playlist = const [],
  });

  @override
  List<Object?> get props => [
        musicList,
        albumList,
        artistList,
        playlist,
      ];

  Future<MusicListState> readLocalMusic({
    List<SongModel>? musicList,
  }) async {
    PermissionStatus readPermission = await Permission.audio.request();
    PermissionStatus notificationPermission =
        await Permission.notification.request();
    final OnAudioQuery audioQuery = OnAudioQuery();

    if (readPermission != PermissionStatus.granted) {
      return this;
    }

    List<SongModel> audios = await audioQuery.querySongs();
    List<AlbumModel> albums = await audioQuery.queryAlbums();
    List<ArtistModel> artists = await audioQuery.queryArtists();

    //print('albums: $albums');
    //print('artists: $artists');
    if (audios.isEmpty) {
      return this;
    }

    return copyWith(musicList: audios, albumList: albums, artistList: artists);
  }

  MusicListState cleanList() {
    return copyWith(
      musicList: [],
      albumList: [],
      artistList: [],
      playlist: [],
    );
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

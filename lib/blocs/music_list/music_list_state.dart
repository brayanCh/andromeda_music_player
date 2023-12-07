part of 'music_list_bloc.dart';

enum Status { win, lose, draw, playing }

class MusicListState {
  List<dynamic> musicList;

  MusicListState({
    this.musicList = const [],
  });

  Future<MusicListState> readLocalMusic({
    List<dynamic>? musicList,
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

    this.musicList = audios;
    return this;
  }

  MusicListState cleanList() {
    musicList = [];
    return this;
  }

  MusicListState copyWith({
    List<String>? musicList,
  }) {
    return MusicListState(
      musicList: musicList ?? this.musicList,
    );
  }
}

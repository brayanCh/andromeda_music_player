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
    Directory? extDir = await getExternalStorageDirectory();

    if (extDir == null) {
      return this;
    }

    List<FileSystemEntity> files =
        extDir.listSync(recursive: true, followLinks: false);
    List<String> musicList = [];
    for (FileSystemEntity file in files) {
      if (file.path.endsWith('.mp3')) {
        musicList.add(file.path);
      }
    }
    print(musicList);
    this.musicList = musicList;
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

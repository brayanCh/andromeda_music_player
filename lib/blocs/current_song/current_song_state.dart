part of 'current_song_bloc.dart';

class AudioPlayerSingleton {
  static final AudioPlayer _instance = AudioPlayer();

  static AudioPlayer getPlayer() {
    return _instance;
  }
}

final class CurrentSongState extends Equatable {
  final SongModel? currentSong;
  final bool isPlaying;
  final AudioPlayer player = AudioPlayerSingleton.getPlayer();

  @override
  List<Object> get props => [currentSong ?? {}, isPlaying];

  CurrentSongState({required this.currentSong, this.isPlaying = false});

  Future<CurrentSongState> setNewSong(SongModel song) async {
    try {
      print('CurrentSongState: setNewSong: song: ${song}');
      AudioSource.uri(Uri.parse(song.data),
          tag: MediaItem(
            // Specify a unique ID for each media item:
            id: song.id.toString(),
            // Metadata to display in the notification:
            album: song.album,
            title: song.title,
          ));
      await player.setFilePath(song.data);
      //player.play();
      return CurrentSongState(currentSong: song, isPlaying: true);
    } catch (e) {
      print('CurrentSongState: setNewSong: error: $e');
      return CurrentSongState(currentSong: song, isPlaying: true);
    }
  }

  CurrentSongState copyWith({SongModel? currentSong, bool? isPlaying}) {
    return CurrentSongState(
        currentSong: currentSong ?? this.currentSong,
        isPlaying: isPlaying ?? this.isPlaying);
  }

  CurrentSongState interact() {
    //print('CurrentSongState: interact: isPlaying: $isPlaying');
    if (player.playing) {
      player.pause();
      return copyWith(isPlaying: false);
    }
    player.play();
    return copyWith(isPlaying: true);
  }
}

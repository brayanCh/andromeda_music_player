part of 'current_song_bloc.dart';

enum Status { win, lose, draw, playing }

final AudioPlayer player = AudioPlayer();

final class CurrentSongState extends Equatable {
  final SongModel? currentSong;
  final bool isPlaying;

  @override
  List<Object> get props => [currentSong ?? {}, isPlaying];

  const CurrentSongState({required this.currentSong, this.isPlaying = false});

  Future<CurrentSongState> setNewSong(SongModel song) async {
    //print('CurrentSongState: setNewSong: song: ${song.title} ${song.artist} ${song.album}');
    await player.setFilePath(song.data);
    player.play();
    return CurrentSongState(currentSong: song, isPlaying: true);
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

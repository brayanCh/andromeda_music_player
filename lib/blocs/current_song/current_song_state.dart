part of 'current_song_bloc.dart';

enum Status { win, lose, draw, playing }

class CurrentSongState {
  SongModel? currentSong;
  final AudioPlayer player = AudioPlayer();
  bool isPlaying = false;

  CurrentSongState({required this.currentSong, this.isPlaying = false});

  CurrentSongState setNewSong(SongModel song) {
    //print('CurrentSongState: setNewSong: song: ${song.title} ${song.artist} ${song.album}');
    currentSong = song;
    player.setFilePath(song.data);
    player.play();
    isPlaying = true;
    return this;
  }

  CurrentSongState interact() {
    print('CurrentSongState: interact: isPlaying: $isPlaying');
    if (player.playing) {
      player.pause();
      isPlaying = false;
      return this;
    }
    player.play();
    isPlaying = true;
    return this;
  }
}

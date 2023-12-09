part of 'current_song_bloc.dart';

@immutable
abstract class CurrentSongEvent {}

class Interact extends CurrentSongEvent {}

class SetNewSong extends CurrentSongEvent {
  final SongModel song;

  SetNewSong(this.song);
}

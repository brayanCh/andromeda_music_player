part of 'music_list_bloc.dart';

@immutable
abstract class MusicListEvent {}

class CleanList extends MusicListEvent {}

class ReadLocalDirs extends MusicListEvent {}

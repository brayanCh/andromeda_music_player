//import 'dart:math';

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

part 'music_list_events.dart';
part 'music_list_state.dart';

class MusicListBloc extends Bloc<MusicListEvent, MusicListState> {
  MusicListBloc() : super(MusicListState()) {
    on<CleanList>((event, emit) => emit(state.cleanList()));
    on<ReadLocalDirs>((event, emit) async {
      await state.readLocalMusic();
    });
  }
}

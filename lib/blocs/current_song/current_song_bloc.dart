//import 'dart:math';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:meta/meta.dart';
import 'package:on_audio_query/on_audio_query.dart';

part 'current_song_events.dart';
part 'current_song_state.dart';

class CurrentSongBloc extends Bloc<CurrentSongEvent, CurrentSongState> {
  CurrentSongBloc() : super(CurrentSongState(currentSong: null)) {
    on<Interact>((event, emit) {
      emit(state.interact());
    });
    on<SetNewSong>((event, emit) async {
      emit(await state.setNewSong(event.song));
    });
  }
}

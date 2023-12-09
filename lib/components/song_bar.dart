import 'package:andromeda_music_player/blocs/current_song/current_song_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SongBar extends StatefulWidget {
  const SongBar({Key? key}) : super(key: key);

  @override
  SongBarState createState() => SongBarState();
}

class SongBarState extends State<SongBar> {
  @override
  Widget build(BuildContext context) {
    final provider = BlocProvider.of<CurrentSongBloc>(context);

    return BlocBuilder<CurrentSongBloc, CurrentSongState>(
        builder: (context, state) {
      return state.currentSong == null || state.currentSong == {}
          ? Container()
          : Positioned(
              bottom: 0,
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(
                      color: Colors.grey[500]!,
                      width: 1.0,
                    ),
                  ),
                ),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.skip_previous),
                    ),
                    Text(
                      '${state.currentSong?.title}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        provider.add(Interact());
                      },
                      icon: state.isPlaying == true
                          ? Icon(Icons.pause)
                          : Icon(Icons.play_arrow),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.skip_next),
                    ),
                  ],
                ),
              ));
    });
  }
}

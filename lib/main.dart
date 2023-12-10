import 'package:andromeda_music_player/blocs/current_song/current_song_bloc.dart';
import 'package:andromeda_music_player/blocs/music_list/music_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio_background/just_audio_background.dart';

import 'screens/song_list_screen.dart';

class AppBlocObserver extends BlocObserver {
  /// {@macro app_bloc_observer}
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
  }

  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    super.onTransition(bloc, transition);
  }
}

void main() {
  Bloc.observer = const AppBlocObserver();
  /*
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  */
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: MultiBlocProvider(providers: [
        BlocProvider<MusicListBloc>(
          create: (contex) => MusicListBloc(),
        ),
        BlocProvider<CurrentSongBloc>(
          create: (contex) => CurrentSongBloc(),
        ),
      ], child: const NavigationContainer()),
    );
  }
}

class NavigationContainer extends StatefulWidget {
  const NavigationContainer({super.key});

  @override
  State<NavigationContainer> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<NavigationContainer> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MusicListBloc, MusicListState>(
        builder: (context, state) {
      return Scaffold(
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          selectedIndex: currentPageIndex,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.music_note),
              label: 'Songs',
            ),
            NavigationDestination(
              icon: Icon(Icons.album),
              label: 'Albums',
            ),
            NavigationDestination(
              icon: Icon(Icons.mic),
              label: 'Artists',
            ),
            NavigationDestination(
              icon: Icon(Icons.list),
              label: 'Playlists',
            ),
          ],
        ),
        body: <Widget>[
          const SongScreen(),
          const Text('Albums'),
          const Text('Artists'),
          const Text('Playlists'),
        ][currentPageIndex],
      );
    });
  }
}

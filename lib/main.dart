import 'package:andromeda_music_player/blocs/music_list/music_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

import 'screens/song_screen.dart';

void main() {
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
              icon: Icon(Icons.folder),
              label: 'Files',
            ),
            NavigationDestination(
              icon: Icon(Icons.list),
              label: 'Playlists',
            ),
          ],
        ),
        body: <Widget>[
          const SongScreen(),
          const Text('Files'),
          const Text('Playlists'),
        ][currentPageIndex],
      );
    });
  }
}

import 'package:flutter/material.dart';

class SongScreen extends StatefulWidget {
  @override
  SongScreenState createState() => SongScreenState();
}

enum SongScreenSection {
  artist,
  album,
  song,
}

class SongScreenState extends State<SongScreen> {
  SongScreenSection currentSection = SongScreenSection.album;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Song Screen'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SegmentedButton(
              selected: <SongScreenSection>{currentSection},
              segments: const <ButtonSegment<SongScreenSection>>[
                ButtonSegment<SongScreenSection>(
                  value: SongScreenSection.artist,
                  label: Text('Artist'),
                ),
                ButtonSegment<SongScreenSection>(
                  value: SongScreenSection.album,
                  label: Text('Album'),
                ),
                ButtonSegment<SongScreenSection>(
                  value: SongScreenSection.song,
                  label: Text('Song'),
                ),
              ],
              onSelectionChanged: (Set<SongScreenSection> section) {
                setState(() {
                  currentSection = section.first;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:asdc/constatns.dart';
import 'package:asdc/core/utils/functions/recording_row.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:audioplayers/audioplayers.dart';

class RecordingsStream extends StatefulWidget {
  const RecordingsStream({super.key});

  @override
  _RecordingsStreamState createState() => _RecordingsStreamState();
}

class _RecordingsStreamState extends State<RecordingsStream> {
  final AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;
   String? currentlyPlayingFilename;

  @override
  void initState() {
    super.initState();
    audioPlayer.onPlayerComplete.listen((event) {
      isPlaying = false;
      setState(() {
        currentlyPlayingFilename = null;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('walkie')
          .orderBy(
            'filename',
            descending: true,
          )
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<RecordingRow> rows = [];
          for (var document in snapshot.data!.docs) {
            rows.add(
              RecordingRow(
                filename: document.data['filename'],
                currentlyPlayingFilename: currentlyPlayingFilename!,
                onTap: (String filename) {
                  setState(() {
                    currentlyPlayingFilename =
                        currentlyPlayingFilename == filename ? null : filename;
                  });
                  isPlaying ? stopPlaying(filename) : startPlaying(filename);
                },
              ),
            );
          }
          return Expanded(
            child: ListView(
              reverse: true,
              children: rows,
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(kColourPrimary!),
            ),
          );
        }
      },
    );
  }

  void startPlaying(String filename) async {
    final url =
        await FirebaseStorage.instance.ref().child(filename).getDownloadURL();
    int result = audioPlayer.play(url) as int;
    if (result == 1) {
      isPlaying = true;
    } else {
      if (kDebugMode) {
        print('Error playing file.');
      }
    }
  }

  void stopPlaying(String filename) async {
    int result =  audioPlayer.stop() as int;
    if (result == 1) {
      isPlaying = false;
      if (currentlyPlayingFilename != null) {
        startPlaying(filename);
      }
    } else {
      if (kDebugMode) {
        print("Can't stop playing!");
      }
    }
  }
}
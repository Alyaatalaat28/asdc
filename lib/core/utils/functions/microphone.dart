// ignore_for_file: must_be_immutable

import 'package:asdc/constatns.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_recorder2/flutter_audio_recorder2.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Microphone extends StatelessWidget {
  final bool isRecording;
  final Function onStartRecording;
  final Function onStopRecording;
    FlutterAudioRecorder2? recorder;

   Microphone({super.key, 
    required this.isRecording,
    required this.onStartRecording,
    required this.onStopRecording,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 96.0,
        color: isRecording ? kColourIsRecording : kColourPrimary,
        child: const Icon(
          Icons.mic,
          size: 48.0,
          color: Colors.white,
        ),
      ),
      onTapDown: (TapDownDetails details) {
        startRecording();
      },
      onTapUp: (TapUpDetails details) {
        stopRecording();
      },
    );
  }

  void startRecording() async {
    try {
      if (await hasPermissions()) {
        onStartRecording();
        String path = await getFilePath();
         FlutterAudioRecorder2(
          path,
          audioFormat: AudioFormat.AAC,
        );
      }
    } catch (error) {
      print(error);
    }
  }

  void stopRecording() async {
    if (isRecording) {
      onStopRecording();
      var recording = await recorder!.stop();
      sendRecording(recording!.path!);
    }
  }

  void sendRecording(String path) {
    final fileName = path.split('/').last;
    FirebaseStorage.instance.ref().child(fileName).putFile(File(path));
    FirebaseFirestore.instance.collection('walkie').add({'filename': fileName});
  }

  Future<bool> hasPermissions() async {
    var status = await Permission.microphone.status;
    switch (status) {
      case PermissionStatus.granted:
        return true;
      case PermissionStatus.restricted:
      case PermissionStatus.denied:
        Permission.microphone.request();
        break;
      case PermissionStatus.restricted:
        print('Microphone access is restricted. You cannot use this app.');
        break;
      case PermissionStatus.permanentlyDenied:
        print('Microsoft access is permanently denied. '
            'You have to go to Settings to enable it.');
        break;
      case PermissionStatus.limited:
        print('Microphone access is limited.');
      case PermissionStatus.provisional:
        print('Microphone access is provisional.');
    }
    return false;
  }

  Future<String> getFilePath() async {
    Directory appDocDirectory = await getApplicationDocumentsDirectory();
    String timestamp = DateTime.now().toIso8601String();
    return '${appDocDirectory.path}/recording_$timestamp.m4a';
  }
}
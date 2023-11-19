import 'package:asdc/constatns.dart';
import 'package:asdc/core/utils/functions/microphone.dart';
import 'package:asdc/core/utils/functions/recording_stream.dart';
import 'package:flutter/material.dart';

class WalkieViewBody extends StatefulWidget {
  const WalkieViewBody({super.key});

  @override
  State<WalkieViewBody> createState() => _WalkieViewBodyState();
}

class _WalkieViewBodyState extends State<WalkieViewBody> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
          color: kColourBackground,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              RecordingsStream(),
              Microphone(
                isRecording: isRecording,
                onStartRecording: () {
                  setState(() {
                    isRecording = true;
                  });
                },
                onStopRecording: () {
                  setState(() {
                    isRecording = false;
                  });
                },
              ),
            ],
          ),
        ),
      );
    
  }
}
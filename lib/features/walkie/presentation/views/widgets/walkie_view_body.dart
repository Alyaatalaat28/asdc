import 'package:asdc/constatns.dart';
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
    return  Container(
      color: kColourBackground,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
         RecordingsStream(),
         
        ],
      ),
    );
  }
}
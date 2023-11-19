import 'package:asdc/constatns.dart';
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
      color: kBackground,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
         RecordingStream(),
         
        ],
      ),
    );
  }
}
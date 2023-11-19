import 'package:asdc/constatns.dart';
import 'package:flutter/material.dart';

import 'widgets/walkie_view_body.dart';

class WalkieView extends StatelessWidget {
  const WalkieView({super.key});
   final bool isRecording=false;
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        backgroundColor:isRecording?kRecording:primaryColor ,
       body:const WalkieViewBody(),
    ));
  }
}
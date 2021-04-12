import 'package:flutter/material.dart';
import '../classes/bird.dart';
import '../library/globals.dart' as globals;

class OverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Bird> birdList = globals.birdList;
    return Scaffold(
      appBar: AppBar(title: Text('Vögel im Portrait')),
      body: ListView.builder(
          itemCount: birdList.length,
          itemBuilder: (context, index) {
            return birdList[index].createCard(context);
          }),
    );
  }
}

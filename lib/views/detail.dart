import 'package:flutter/material.dart';
import '../classes/bird.dart';
import '../widgets/app_heading.dart';

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Bird bird = ModalRoute.of(context).settings.arguments as Bird;
    return Scaffold(
        appBar: AppBar(title: Text('${bird.title}')),
        body: Column(children: [
          vogelHeading(),
          Expanded(
              child: Container(
                  color: Colors.white,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text('Detail'),
                      ])))
        ]));
  }
}

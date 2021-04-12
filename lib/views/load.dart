// dart
import 'dart:async';
//packages
import 'package:flutter/material.dart';
// own stuff
import '../services/api_manager.dart';
import '../classes/bird.dart';

class LoadScreen extends StatefulWidget {
  LoadScreen({Key key}) : super(key: key);

  @override
  _LoadScreenState createState() => _LoadScreenState();
}

class _LoadScreenState extends State<LoadScreen> {
  Future<List<Bird>> futureBirds;

  @override
  void initState() {
    super.initState();
    futureBirds = fetchBirds();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loading Data',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text('Vögel')),
        body: Center(
          child: FutureBuilder<List<Bird>>(
            future: futureBirds,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                List birds = snapshot.data;
                return ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        child: Text('Spielen'),
                        onPressed: () {
                          print('game');
                          print(snapshot.data[0].slug);
                          Navigator.pushNamed(context, '/game',
                              arguments: birds);
                        },
                      ),
                      ElevatedButton(
                        child: Text('Lernen'),
                        onPressed: () {
                          print('lernen');
                          print(snapshot.data[0].slug);
                          Navigator.pushNamed(context, '/overview',
                              arguments: birds);
                        },
                      )
                    ]);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}

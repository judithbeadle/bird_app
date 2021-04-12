import 'package:flutter/material.dart';
import 'views/overview.dart';
import 'views/game.dart';
import 'views/detail.dart';
import 'services/api_manager.dart';
import 'library/globals.dart' as globals;

void main() {
  runApp(MaterialApp(
    initialRoute: '/start',
    routes: {
      '/start': (context) => StartScreen(),
      '/overview': (context) => OverviewScreen(),
      '/game': (context) => GameScreen(),
      '/detail': (context) => DetailScreen(),
    },
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primarySwatch: Colors.lightGreen),
    // TODO global TextDirection
    // TODO colors etc
  ));
}

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  Future<List> futureBirds;

  @override
  void initState() {
    super.initState();
    //futureBirds = fetchBirds();
    globals.birdList = fetchBirds();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('../assets/images/amsel-large.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 32.0),
        child: Column(children: [
          Expanded(
              child: Container(
            child: Text(
              'Zwei Vögel wollten Hochzeit feiern...',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          )),
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 2,
                  offset: Offset(0, 2), // changes position of shadow
                ),
              ],
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    'Amsel, Drossel, Fink und Star - Welche Vögel kennst du schon? Entdecke Wissenswertes zu den Vögeln in der Stadt.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  FutureBuilder<List>(
                    future: globals.birdList,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        // assigning data to global list, so it is available throughout
                        globals.birdList = snapshot.data;
                        return ButtonBar(
                            alignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                child: Text('Spielen'),
                                onPressed: () {
                                  print(snapshot.data[0].slug);
                                  Navigator.pushNamed(
                                    context,
                                    '/game',
                                  );
                                },
                              ),
                              ElevatedButton(
                                child: Text('Lernen'),
                                onPressed: () {
                                  print('lernen');
                                  print(snapshot.data[0].slug);
                                  Navigator.pushNamed(
                                    context,
                                    '/overview',
                                  );
                                },
                              )
                            ]);
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }

                      // By default, show a loading spinner.
                      return CircularProgressIndicator();
                    },
                  )
                ],
              ),
            ),
          ),
        ]),
      ),
    ));
  }
}

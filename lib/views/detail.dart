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
          Expanded(
              child: Container(
                  color: Colors.white,
                  child: ListView(
                    children: [
                      Hero(
                        tag: 'bird-${bird.slug}',
                        child: Image(
                            image: AssetImage('images/${bird.slug}-large.jpg')),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Card(
                                child: ListTile(
                              leading: Icon(Icons.info_outline),
                              title: Text(bird.scientific),
                            )),
                            Card(
                                child: ListTile(
                              leading: Icon(Icons.info_outline),
                              title: Text(bird.lebensraum),
                            )),
                            Card(
                                child: ListTile(
                              leading: Icon(Icons.info_outline),
                              title: Text(bird.nahrung),
                            )),
                          ],
                        ),
                      ),
                    ],
                  )))
        ]));
  }
}

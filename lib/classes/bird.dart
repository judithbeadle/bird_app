import 'package:flutter/material.dart';

class Bird {
  final String slug;
  final int id;
  final String title;
  String sex;

  void setSex(String letter) {
    this.sex = letter;
  }

  Bird({
    @required this.slug,
    @required this.id,
    @required this.title,
    this.sex = 'm',
    setSex(),
  });

  factory Bird.fromJson(Map<String, dynamic> json) {
    return Bird(
      slug: json['slug'],
      id: json['id'],
      title: json['title']['rendered'],
    );
  }

  Card createCard(context) {
    return Card(
        child: ListTile(
      onTap: () {
        Navigator.pushNamed(context, '/detail', arguments: this);
      },
      leading: CircleAvatar(
        backgroundColor: Colors.teal,
        child: ClipOval(
          child: Hero(
            tag: 'bird-${this.slug}',
            child:
                Image(image: AssetImage('images/${this.slug}-thumbnail.jpg')),
          ),
        ),
      ),
      title: Text(this.title),
      subtitle: Text(this.slug,
          style: TextStyle(
            fontSize: 16,
          )),
      trailing: IconButton(
        icon: Icon(Icons.more_horiz, color: Colors.teal),
        onPressed: () {
          // TODO: add icons for Lebensraum, Nahrung,???
          print('info');
        },
      ),
    ));
  }
}

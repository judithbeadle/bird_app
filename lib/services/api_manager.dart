// dart
import 'dart:async';
import 'dart:convert';
// packages
import 'package:http/http.dart' as http;
// own stuff
import '../classes/bird.dart';

// Bird
Future<List<Bird>> fetchBirds() async {
  final response = await http.get(
    Uri.parse('https://natureapp.jbeadle.de/wp-json/wp/v2/vogel?_embed'),
    // headers: {HttpHeaders.authorizationHeader: "Basic your_api_token_here"},
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response, parse the JSON.
    final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
    return parsed.map<Bird>((json) => Bird.fromJson(json)).toList();
  } else {
    // If the server did not return a 200 OK response, throw an exception.
    throw Exception('Failed to load birds');
  }
}

import 'package:flutter/material.dart';
import 'package:peliculas_app/src/pages/actor_detail.dart';
import 'package:peliculas_app/src/pages/home_page.dart';
import 'package:peliculas_app/src/pages/pelicula_detailed.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Peliculas',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => HomePage(),
        'detailed': (BuildContext context) => DetailedPelicula(),
        'act-detailed': (BuildContext context) => ActorDetailed()
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:peliculas_app/src/models/pelicula_model.dart';
import 'package:peliculas_app/src/providers/peliculas_provider.dart';

class DataSearch extends SearchDelegate {
  String selected = '';

  final peliculasProvider = new PeliculasProvider();

  final peliculas = [
    'spiderman',
    'capitan america',
    'hulk',
    'thor',
    'black widow'
  ];
  final peliculasRecientes = ['spiderman', 'thor'];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
            print("click");
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    }
    return FutureBuilder(
      future: peliculasProvider.buscarPelicula(query),
      //initialData: ,
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: FadeInImage(
                  placeholder: AssetImage("assets/img/loading.gif"),
                  image: NetworkImage(snapshot.data[index].getPosterImg()),
                  fit: BoxFit.contain,
                  width: 50.0,
                ),
                title: Text(snapshot.data[index].title),
                subtitle: Text(snapshot.data[index].originalLanguage),
                onTap: () {
                  close(context, null);
                  snapshot.data[index].uniqueId = '';
                  Navigator.pushNamed(context, 'detailed',
                      arguments: snapshot.data[index]);
                },
              );
            },
            itemCount: snapshot.data.length,
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

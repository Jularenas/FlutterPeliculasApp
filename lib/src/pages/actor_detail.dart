import 'package:flutter/material.dart';
import 'package:peliculas_app/src/models/actor_model.dart';
import 'package:peliculas_app/src/models/person_model.dart';
import 'package:peliculas_app/src/providers/peliculas_provider.dart';

class ActorDetailed extends StatelessWidget {
  final peliculasProvider = new PeliculasProvider();

  @override
  Widget build(BuildContext context) {
    final Actor actor = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        appBar: AppBar(
          title: Text(actor.name),
        ),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverList(
                delegate: SliverChildListDelegate([
              Container(
                child: Column(children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(20.0),
                        child: Column(children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image(
                              image: NetworkImage(actor.getFoto()),
                              height: 150,
                            ),
                          ),
                        ]),
                      ),
                      Container(
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Icon(Icons.person),
                                Text(
                                  actor.genderString,
                                  style: TextStyle(fontSize: 20),
                                )
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Icon(Icons.label),
                                Text(
                                  actor.name,
                                  style: TextStyle(fontSize: 20),
                                )
                              ],
                            )
                          ],
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                      )
                    ],
                  ),
                  _person(actor)
                ]),
              ),
            ]))
          ],
        ));
  }

  Widget _person(Actor actor) {
    final fut = FutureBuilder(
      future: peliculasProvider.obtenerPersona(actor.id),
      //initialData: InitialData,
      builder: (BuildContext context, AsyncSnapshot<Person> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.adult == null) {
            return Container();
          } else {
            return ListTile(
              leading: Icon(Icons.book),
              title: Text(
                "Biography",
                style: TextStyle(fontSize: 20.0),
              ),
              subtitle: Text(snapshot.data.biography),
            );
          }
        } else {
          return CircularProgressIndicator();
        }
      },
    );

    return fut;
  }

  Widget _scrollActor(Actor actor) {
    return CustomScrollView(
      slivers: <Widget>[_person(actor)],
    );
  }
}

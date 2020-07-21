import 'package:flutter/material.dart';
import 'package:peliculas_app/src/models/pelicula_model.dart';
import 'package:peliculas_app/src/models/actor_model.dart';
import 'package:peliculas_app/src/providers/peliculas_provider.dart';

class DetailedPelicula extends StatelessWidget {
  //const DetailedPelicula({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _crearAppBar(pelicula),
          SliverList(
              delegate: SliverChildListDelegate([
            SizedBox(
              height: 10.0,
            ),
            _posterTitulo(context, pelicula),
            _descripcion(pelicula),
            _descripcion(pelicula),
            _descripcion(pelicula),
            _descripcion(pelicula),
            _cast(pelicula)
          ]))
        ],
      ),
    );
  }

  Widget _crearAppBar(Pelicula pelicula) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          pelicula.title,
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/img/loading.gif'),
          image: NetworkImage(pelicula.getBackgroundIamge()),
          fadeOutDuration: Duration(milliseconds: 150),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _posterTitulo(BuildContext context, Pelicula pelicula) {
    final originalTitle =
        pelicula.originalTitle != null ? pelicula.originalTitle : "";
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Hero(
            tag: pelicula.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image(
                image: NetworkImage(pelicula.getPosterImg()),
                height: 150,
              ),
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          Flexible(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                pelicula.title,
                style: Theme.of(context).textTheme.title,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                originalTitle,
                style: Theme.of(context).textTheme.subhead,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: <Widget>[
                  Icon(Icons.star_border),
                  Text(
                    pelicula.voteAverage.toString(),
                    style: Theme.of(context).textTheme.subhead,
                  )
                ],
              )
            ],
          ))
        ],
      ),
    );
  }

  Widget _descripcion(Pelicula pelicula) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Text(
        pelicula.overview,
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _cast(Pelicula pelicula) {
    final peliculasProvider = new PeliculasProvider();

    return FutureBuilder(
      future: peliculasProvider.getCast(pelicula.id.toString()),
      //initialData: [],
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return _crearActoresPageView(snapshot.data);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _crearActoresPageView(List<Actor> actores) {
    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        pageSnapping: false,
        itemBuilder: (BuildContext context, int index) {
          return _actor(actores[index]);
        },
        itemCount: actores.length,
        controller: PageController(viewportFraction: 0.3, initialPage: 1),
      ),
    );
  }

  Widget _actor(Actor actor) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: FadeInImage(
                  height: 150.0,
                  fit: BoxFit.cover,
                  placeholder: AssetImage("assets/img/loading.gif"),
                  image: NetworkImage(actor.getFoto())),
            ),
          ),
          Text(
            actor.name,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}

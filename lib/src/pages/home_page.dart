import 'package:flutter/material.dart';
import 'package:peliculas_app/src/models/pelicula_model.dart';
import 'package:peliculas_app/src/providers/peliculas_provider.dart';
import 'package:peliculas_app/src/search/search_delegate.dart';
import 'package:peliculas_app/src/widgets/card_swiper.dart';
import 'package:peliculas_app/src/widgets/horizontal_page_view.dart';

class HomePage extends StatelessWidget {
  //const HomePage({Key key}) : super(key: key);
  final peliculasProvider = new PeliculasProvider();

  @override
  Widget build(BuildContext context) {
    peliculasProvider.getPopulares();
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: DataSearch());
              })
        ],
        backgroundColor: Colors.indigoAccent,
        title: SafeArea(child: Text("Peliculas App")),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[_swiperTarjetas(), _footer(context)],
        ),
      ),
    );
  }

  Widget _swiperTarjetas() {
    //peliculasProvider.getEnCines();
    //final peliculas = new Peliculas.fromJsonList(jsonList);
    return FutureBuilder(
      future: peliculasProvider.getEnCines(),
      //initialData: [],
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(peliculas: snapshot.data);
        } else {
          return Container(
            child: Center(child: CircularProgressIndicator()),
            height: 400,
          );
        }
      },
    );
    //return CardSwiper(peliculas: [1, 2, 3, 4, 5]);
  }

  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 40),
            child: Text(
              'Populares',
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          StreamBuilder(
              stream: peliculasProvider.popularesStream,
              //initialData: InitialData,
              builder: (BuildContext context,
                  AsyncSnapshot<List<Pelicula>> snapshot) {
                if (snapshot.hasData) {
                  return HorizontalPageView(
                    peliculas: snapshot.data,
                    siguientePagina: peliculasProvider.getPopulares,
                  );
                } else {
                  return Container(
                    child: Center(child: CircularProgressIndicator()),
                    height: 200,
                  );
                }
              }),
        ],
      ),
    );
  }
}

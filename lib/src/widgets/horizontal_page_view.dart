import 'package:flutter/material.dart';
import 'package:peliculas_app/src/models/pelicula_model.dart';

class HorizontalPageView extends StatelessWidget {
  //const HorizontalPageView({Key key}) : super(key: key);

  List<Pelicula> peliculas;

  //PageController _pageController = new PageController();

  final _pageController = PageController(initialPage: 1, viewportFraction: 0.3);

  final Function siguientePagina;

  HorizontalPageView({@required this.peliculas, this.siguientePagina});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        print('carga 10 mas');
        siguientePagina();
      }
    });

    return Container(
      height: _screenSize.height * 0.2,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        //children: _listaPopulares(),
        itemCount: peliculas.length,
        itemBuilder: (BuildContext context, int i) {
          return _tarjeta(context, peliculas[i]);
        },
      ),
    );
  }

  Widget _tarjeta(BuildContext context, Pelicula pelicula) {
    pelicula.uniqueId = "${pelicula.id}-poster";
    final tarjeta = Container(
      margin: EdgeInsets.only(right: 5.0),
      child: Column(
        children: <Widget>[
          Hero(
            tag: pelicula.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                  fit: BoxFit.cover,
                  height: 144,
                  placeholder: AssetImage("assets/img/loading.gif"),
                  image: NetworkImage(pelicula.getPosterImg())),
            ),
          ),
          Text(
            pelicula.title == null ? "" : pelicula.title,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );

    return GestureDetector(
      child: tarjeta,
      onTap: () {
        print("${pelicula.title}");
        print("${pelicula.id}");
        Navigator.pushNamed(context, 'detailed', arguments: pelicula);
      },
    );
  }

  List<Widget> _listaPopulares() {
    return peliculas.map((pelicula) {
      //print(pelicula.title);
      return Container(
        margin: EdgeInsets.only(right: 5.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                  fit: BoxFit.cover,
                  height: 144,
                  placeholder: AssetImage("assets/img/loading.gif"),
                  image: NetworkImage(pelicula.getPosterImg())),
            ),
            Text(
              pelicula.title == null ? "" : pelicula.title,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      );
    }).toList();
  }
}

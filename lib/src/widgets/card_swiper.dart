import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas_app/src/models/pelicula_model.dart';

class CardSwiper extends StatelessWidget {
  //const CardSwiper({Key key}) : super(key: key);

  final List<Pelicula> peliculas;

  CardSwiper({@required this.peliculas});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    //print(this.peliculas[0].toString());

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      //width: _screenSize.width * 0.7,
      //height: _screenSize.height * 0.5,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          peliculas[index].uniqueId = "${peliculas[index].id}-card";
          return Hero(
            tag: peliculas[index].uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, 'detailed',
                      arguments: peliculas[index]);
                },
                child: FadeInImage(
                  placeholder: AssetImage("assets/img/loading.gif"),
                  image: NetworkImage(peliculas[index].getPosterImg()),
                  fit: BoxFit.cover,
                  //height: 500,
                ),
              ),
            ),
          );
        },
        //indicatorLayout: PageIndicatorLayout.COLOR,
        //autoplay: true,
        layout: SwiperLayout.STACK,
        itemCount: peliculas.length,
        itemWidth: _screenSize.width * 0.7,
        itemHeight: _screenSize.height * 0.45,
        //control: new SwiperControl(),
        //pagination: new SwiperPagination(),
      ),
    );
  }
}

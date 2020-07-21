import 'dart:async';

import 'package:peliculas_app/src/models/actor_model.dart';
import 'package:peliculas_app/src/models/pelicula_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PeliculasProvider {
  String _apiKey = '90e21880b19dbca627f2a3d49307a259';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';
  int _popularesPage = 2;
  bool _loading = false;

  List<Pelicula> _populares = new List();
  final _popularesStreamController =
      StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularesSink =>
      _popularesStreamController.sink.add;
  Stream<List<Pelicula>> get popularesStream =>
      _popularesStreamController.stream;

  void disposeStreams() {
    _popularesStreamController?.close();
  }

  Future<List<Pelicula>> _processRequest(Uri url) async {
    final resp = await http.get(url);

    final decoded = json.decode(resp.body);

    final peliculas = new Peliculas.fromJsonList(decoded['results']);

    return peliculas.items;
  }

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language,
    });

    return await _processRequest(url);
  }

  Future<List<Pelicula>> getPopulares() async {
    if (_loading) {
      return [];
    }

    _loading = true;

    this._popularesPage++;
    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
      'page': this._popularesPage.toString()
    });

    final resp = await _processRequest(url);

    _populares.addAll(resp);
    popularesSink(_populares);

    _loading = false;

    return resp;
  }

  Future<List<dynamic>> getCast(String id) async {
    final url = Uri.https(_url, '3/movie/$id/credits',
        {'api_key': _apiKey, 'language': _language});

    final resp = await http.get(url);

    final decoded = json.decode(resp.body);

    final cast = Cast.fromJson(decoded['cast']);

    return cast.actores;
  }

  Future<List<Pelicula>> buscarPelicula(String query) async {
    final url = Uri.https(_url, '3/search/movie',
        {'api_key': _apiKey, 'language': _language, 'query': query});

    return await _processRequest(url);
  }
}

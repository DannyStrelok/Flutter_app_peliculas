import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:practica_peliculas/src/models/pelicula_model.dart';

class PeliculasProvider {
  String _apikey = '43629ecc753794f9d915d6400e8cec17';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  Future<List<Pelicula>> _processResponse(Uri url) async {

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    final peliculas = new Peliculas.fromJsonList(decodedData['results']);

    return peliculas.items;
  }

  Future<List<Pelicula>> getInCinema() async {

    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key' : _apikey,
      'language' : _language
    });

    return await _processResponse(url);
  }

  Future<List<Pelicula>> getPopular() async {
    final url = Uri.https(_url, '3/movie/popular', {
      'api_key' : _apikey,
      'language' : _language
    });

    return await _processResponse(url);
  }

}
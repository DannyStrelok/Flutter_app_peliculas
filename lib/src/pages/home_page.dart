import 'package:flutter/material.dart';
import 'package:practica_peliculas/src/models/pelicula_model.dart';
import 'package:practica_peliculas/src/providers/peliculas_provider.dart';
import 'package:practica_peliculas/src/widgets/card_swiper_widget.dart';
import 'package:practica_peliculas/src/widgets/movie_horizontal.dart';

class HomePage extends StatelessWidget {
  final peliculasProvider = new PeliculasProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Peliculas en cines'),
          backgroundColor: Colors.indigoAccent,
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            )
          ],
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [_cardSwiper(), _footer(context)],
          ),
        ));
  }

  Widget _cardSwiper() {
    return FutureBuilder(
        future: peliculasProvider.getInCinema(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            return CardSwiper(peliculas: snapshot.data);
          } else {
            return Container(
                height: 400, child: Center(child: CircularProgressIndicator()));
          }
        });
  }

  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              'Populares',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          SizedBox(height: 5,),
          FutureBuilder(
            future: peliculasProvider.getPopular(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if(snapshot.hasData) {
                return MovieHorizontal(peliculas: snapshot.data);
              } else {
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }
}

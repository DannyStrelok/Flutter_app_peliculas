import 'package:flutter/material.dart';
import 'package:practica_peliculas/src/models/pelicula_model.dart';

class MovieHorizontal extends StatelessWidget {

  final List<Pelicula> peliculas;
  final _pageController = new PageController(
      initialPage: 1,
      viewportFraction: 0.3
  );

  final Function siguientePagina;

  MovieHorizontal({@required this.peliculas, @required this.siguientePagina});

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      if( _pageController.position.pixels >= _pageController.position.maxScrollExtent - 200) {
        print('CARGAR MAS PELICULAS');
        siguientePagina();
      }
    });

    return Container(
      height: _screenSize.height * 0.3,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        //children: _tarjetas(context),
        itemCount: peliculas.length,
        itemBuilder: (context, i) {
            return _tarjeta(context, peliculas[i]);
        },
      ),
    );
  }

  Widget _tarjeta(BuildContext context, Pelicula pelicula) {

    pelicula.uuid = '${pelicula.id}-poster';

    final tarjeta =  Container(
      margin: EdgeInsets.only(right: 15),
      child: Column(
        children: [
          Hero(
            tag: pelicula.uuid,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                image: NetworkImage(pelicula.getPosterImg()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.cover,
                height: 160,
              ),
            ),
          ),
          SizedBox(height: 15,),
          Text(
            pelicula.title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          )
        ],
      ),
    );

    return GestureDetector(
      onTap: () {
        print('ID de la pelicula ${pelicula.id}');
        Navigator.pushNamed(context, 'detalle', arguments: pelicula);
      },
      child: tarjeta,
    );

  }

  List<Widget> _tarjetas(BuildContext context) {

    return peliculas.map( (p) {
      return Container(
        margin: EdgeInsets.only(right: 15),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                image: NetworkImage(p.getPosterImg()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.cover,
                height: 160,
              ),
            ),
            SizedBox(height: 15,),
            Text(
              p.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            )
          ],
        ),
      );
    } ).toList();

  }

}

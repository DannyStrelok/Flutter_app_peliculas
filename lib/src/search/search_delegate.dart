import 'package:flutter/material.dart';
import 'package:practica_peliculas/src/models/pelicula_model.dart';
import 'package:practica_peliculas/src/providers/peliculas_provider.dart';

class DataSearch extends SearchDelegate {

  String seleccion = '';
  final peliculasProvider = new PeliculasProvider();

  final peliculas = [
    'Spiderman',
    'Aquaman',
    'Batman',
    'Xmen',
    'Ironman',
    'Capitán América'
  ];

  final peliculasRecientes = ['Spiderman', 'Capitan America'];

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: Las acciones de nuestro AppBar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: Icono a la izquierda del AppBar
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: AnimatedIcon(
          progress: transitionAnimation, icon: AnimatedIcons.menu_arrow),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: Builder que muestra los resultados
    return Container();
    return Center(
      child: Container(
        height: 100,
        width: 100,
        color: Colors.amberAccent,
        child: Text(seleccion),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: Las sugerencias cuando se escribe en el appbar

    if(query.isEmpty) {
      return Container();
    }

    return FutureBuilder(
      future: peliculasProvider.buscarPelicula(query),
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
        if(snapshot.hasData) {
          final peliculas = snapshot.data;
          return ListView(
            children: peliculas.map((p) {
              return ListTile(
                leading: FadeInImage(
                  image: NetworkImage(p.getPosterImg()),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  width: 50,
                  fit: BoxFit.contain,
                ),
                title: Text(p.title),
                subtitle: Text(p.originalTitle),
                onTap: (){
                  close(context, null);
                  p.uuid = '';
                  Navigator.pushNamed(context, 'detalle', arguments: p);
                },
              );
            }).toList()
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );

  }

  // @override
  // Widget buildSuggestions(BuildContext context) {
  //   // TODO: Las sugerencias cuando se escribe en el appbar
  //
  //   final listaSugerida = (query.isEmpty)
  //       ? peliculasRecientes
  //       : peliculas
  //           .where((element) =>
  //               element.toLowerCase().startsWith(query.toLowerCase()))
  //           .toList();
  //
  //   return ListView.builder(
  //     itemCount: listaSugerida.length,
  //     itemBuilder: (context, i) {
  //       return ListTile(
  //         leading: Icon(Icons.movie),
  //         title: Text(listaSugerida[i]),
  //         onTap: () {
  //           seleccion = listaSugerida[i];
  //           //showResults(context);
  //         },
  //       );
  //     },
  //   );
  // }
}

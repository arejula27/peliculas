import 'package:flutter/material.dart';
import 'package:peliculas/providers/peliculas_provider.dart';
import 'package:peliculas/src/models/pelicula_models.dart';

class DataDelegate extends SearchDelegate {

  String selection="";

    final pelisProvider = new PeliculasProvider();



  @override
  List<Widget> buildActions(BuildContext context) {
    // Iconos a la derecha de la barra de search
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed:(){
          query="";
        } ,
        
      )

    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Iconos a la izquierda de la barra de search
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,  
      ),
      onPressed: (){
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Los resultados que vamos a mostrar
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Sugerencias mientras escribimos 
    if (query.isEmpty){
      return Container();
    }
    return FutureBuilder(
      future: pelisProvider.getSearch(query) ,
      
      builder: (BuildContext context, AsyncSnapshot <List<Pelicula>> snapshot) {

        if (snapshot.hasData){

          final pelis = snapshot.data;
          return ListView(
            children: pelis.map((Pelicula peli){

              return Column(
                  children: [
                    ListTile(
                      leading:  FadeInImage(
                       width: 50.0,
                        fit: BoxFit.contain,
                        placeholder: AssetImage("assets/img/no-image.jpg"),
                        image: NetworkImage(peli.getPosterUrl()) ,
                        ),
                  
                    onTap: (){
                      close(context, null);
                      peli.uniqueId="${peli.id}-search";
                      Navigator.pushNamed(context, 'detalles',arguments: peli);
                    },
                    title: Text(peli.title),
                    ),
                    SizedBox(height: 10,),
                  ]
              );
              
              
            }).toList(),
          ) ;
        }else{
          return Center(child: CircularProgressIndicator(),);
        }
        
      },
    );
    
  }
  
}
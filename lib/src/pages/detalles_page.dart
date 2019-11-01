import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_models.dart';


class Detalles extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
final Pelicula pelicula = ModalRoute.of(context).settings.arguments;
   
    return Scaffold(
      body: CustomScrollView(
        //en vez de children recive slivers
        slivers: <Widget>[
          _crearAppBar(pelicula),
          //Cuando no tienes que usar slivers en una customScroolview
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(height: 10.0,),
              _posterTitulo(pelicula,context),
              _descripcion(pelicula),
              ]
              
            ),
          )
        ],
      )
        
      );

  }

  Widget _crearAppBar(Pelicula pelicula) {

return SliverAppBar(
  //hasta donde se contrae
    elevation: 20,
    backgroundColor: Colors.indigoAccent,
    //como es de normal
    expandedHeight: 200.0,
    floating: false,
    //no desaparece
    pinned: true,
    //el widget que se encuentra en el appbar y se contrae junto a ellla
    flexibleSpace: FlexibleSpaceBar(
      centerTitle: true,
      title: Padding(
        padding: EdgeInsets.symmetric(horizontal: 75.0),
        child:Text(
            pelicula.title,
            style: TextStyle(color: Colors.white,fontSize: 16.0),
            overflow: TextOverflow.ellipsis,
          ),
        
      ),
      
      //background:Image(image:NetworkImage(pelicula.getBackgroundImg() ,),)
     background: FadeInImage(
          image: NetworkImage( pelicula.getBackgroundImg() ),
          placeholder: AssetImage('assets/img/loading.gif'),
          //falla si uso el fadeDuration
          //fadeInDuration: Duration(microseconds: 150),
          fit: BoxFit.cover,
        ),
    )

);
  }

  Widget _posterTitulo(Pelicula pelicula,context){ 

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        
        children: <Widget>[
          
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image(
            image: NetworkImage(pelicula.getPosterUrl()),
            height: 150.0,
          ),),
          SizedBox(width: 20.0,),
          //arregla eeror de overflow en texto
          Flexible(
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(pelicula.title, style: Theme.of(context).textTheme.title, overflow: TextOverflow.ellipsis, ),
                Text(pelicula.title, style: Theme.of(context).textTheme.title, overflow: TextOverflow.ellipsis, ),
                SizedBox(height: 15.0,),
                Row(
                  children: <Widget>[
                    Icon(Icons.star_border),
                    Text(
                      pelicula.voteAverage.toString(),
                      style: Theme.of(context).textTheme.subhead

                    )
                  ],
                )
              ],
            ), 
          )
          
          
          
        ],
      ),
    );


  }

  Widget _descripcion(Pelicula pelicula) {

    return Container(
      child: Text(pelicula.overview),);
  }


}
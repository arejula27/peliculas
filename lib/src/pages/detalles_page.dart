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
              ]
              
            ),
          )
        ],
      )
        
      );

  }

  Widget _crearAppBar(pelicula) {

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
      title: Text(
        pelicula.title,
        style: TextStyle(color: Colors.white,fontSize: 16.0),
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

  Widget _posterTitulo(pelicula,context){ 

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
          Column(
            children: <Widget>[
              Text(pelicula.title, style: Theme.of(context).textTheme.title, overflow: TextOverflow.ellipsis, ),
                Text(pelicula.originalTitle, style: Theme.of(context).textTheme.subtitle, overflow: TextOverflow.ellipsis,),
              ],
            ),
          
          
        ],
      ),
    );


  }


}
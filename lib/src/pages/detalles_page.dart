import 'package:flutter/material.dart';
import 'package:peliculas/providers/peliculas_provider.dart';
import 'package:peliculas/src/models/actores_models.dart';
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
              SizedBox(height: 10.0,),
              _crearCasting(pelicula),
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
          
          Hero(
            
            tag: pelicula.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image(
              image: NetworkImage(pelicula.getPosterUrl()),
              height: 150.0,
            ),),
          ),
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
      padding: EdgeInsets.only(top: 14.0, left: 20.0, right: 20.0),
      
      child: Text(pelicula.overview),);
  }

  Widget _crearCasting(Pelicula pelicula) {

    // necesitamos el peli provider que contenga los futures
    final peliProvider = PeliculasProvider();
    return FutureBuilder(
      future: peliProvider.getCast(pelicula.id.toString()),
      
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        
        if(snapshot.data==null)return Center(child: Padding(
          padding: const EdgeInsets.only(top:50.0),
          child: CircularProgressIndicator(),
        ));
        return _crearActoresPageView(snapshot.data);
      },
    );
    
  }

  Widget _crearActoresPageView(List<Actor> actores) {

    return SizedBox(
      height: 200.0,
      child:PageView.builder(
        pageSnapping: false,
        controller: PageController(
          viewportFraction: 0.3,
          initialPage: 1,
        ),
        itemCount: actores.length,
        itemBuilder: ( context,i){
          //return Text(actores[i].name);
          return _cardActores(actores[i]);
        },
      ) ,);




  }

  Widget _cardActores(Actor actor) {

    return Container(
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              image: NetworkImage( actor.getPhoto() ),
              placeholder: AssetImage('assets/img/no-image.jpg'),
              height: 150.0,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            actor.name,
            overflow: TextOverflow.ellipsis,
          )
        ],
      )
    );
  }


}
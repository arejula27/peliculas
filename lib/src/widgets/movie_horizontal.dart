import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_models.dart';


class MovieHorizontal extends StatelessWidget{

  final List<Pelicula> peliculas;
  final Function nextpage;



  MovieHorizontal({@required this.peliculas,@required this.nextpage});

  final _pageController =new PageController(viewportFraction: 0.3,initialPage: 1);

  @override
  Widget build(BuildContext context) {

      _pageController.addListener((){

        if(_pageController.position.pixels>=_pageController.position.maxScrollExtent-300){

          nextpage();


        }

      });
      final _screenSize =MediaQuery.of(context).size;
    
    return Container(
      //padding: EdgeInsets.only(bottom: 20.0),
      height: _screenSize.height*0.25,
      child: PageView.builder(
        controller: _pageController,
        pageSnapping: false,//si esta a false al deslizar continuara deslizandose sin tocar la pantalla
        //children: _cardList(),
        itemBuilder: (context,i){

            return _cardPeli(context, peliculas[i]);
        },
        itemCount: peliculas.length,
      ),
    );
  }

  Widget _cardPeli(context,Pelicula pelicula){

    
        final peli = Container(
          
          
          margin: EdgeInsets.only(right: 20.0),
          child: Column(
            children: <Widget>[
              ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: FadeInImage(
                  image: NetworkImage(pelicula.getPosterUrl()),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  fit: BoxFit.cover,
                  height: 150.0,
                ),
              ),
              Text(
                pelicula.title,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.caption,
                //style:TextStyle(fontSize: 6.0)
               ),
            ],),
        );

        return GestureDetector(
          child: peli,
          onTap: (){
            //Cambias de pagina pero la das arguentos
            Navigator.pushNamed(context, 'detalles',arguments: pelicula);
          },
        );




  }


//Crea yna lista de cards con las fotos y imensiones ya puestas
//la use al principio pero para usar el itembuilder hice otra funcion
 /* List<Widget> _cardList() {

    return peliculas.map((pelicula){
        return Container(
          margin: EdgeInsets.only(right: 20.0),
          child: Column(
            children: <Widget>[
              ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: FadeInImage(
                    image: NetworkImage(pelicula.getPosterUrl()),
                    placeholder: AssetImage('assets/img/no-image.jpg'),
                    fit: BoxFit.cover,
                   height: 100.0,
                  ),
              )
            ],),
        );


    }).toList();





  }*/



  
}
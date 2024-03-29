import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas/src/models/pelicula_models.dart';

class CardSwiper extends StatelessWidget {

  final List<Pelicula> peliculas;


  CardSwiper({@required this.peliculas});

  @override
  Widget build(BuildContext context) {


    //obtener el tamaño de la pantalla
    final _screenSize= MediaQuery.of(context).size;


      return Container(
              padding: EdgeInsets.only(top: 10.0),
                width: double.infinity,
                //height: _screenSize.height*0.5,
                //color: Colors.red,
              
              child: Swiper(
                
                layout: SwiperLayout.STACK,
                itemWidth: _screenSize.width*0.6,
                
                itemHeight: _screenSize.height*0.45, 
                
               itemBuilder: (BuildContext context,int index){
                 peliculas[index].uniqueId = "${peliculas[index].id}-swiper";
                return GestureDetector(
                  onTap: (){Navigator.pushNamed(context, 'detalles',arguments: peliculas[index]);},
                  child: Hero(
                    
                    tag: peliculas[index].uniqueId,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: FadeInImage(
                        image:NetworkImage(peliculas[index].getPosterUrl()),
                        placeholder: AssetImage('assets/img/no-image.jpg'),
                        fit: BoxFit.cover,
                      ),
                      //child: Container(color: Colors.blue,),
                      
                    ),
                  ),
                );
              },
                
                itemCount: peliculas.length,
                
              //pagination: new SwiperPagination(),
              //control: new SwiperControl(),
            ),
          );
          
        }
}
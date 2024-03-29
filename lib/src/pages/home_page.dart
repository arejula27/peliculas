import 'package:flutter/material.dart';
import 'package:peliculas/providers/peliculas_provider.dart';
import 'package:peliculas/src/search/search_delegat.dart';
import 'package:peliculas/src/widgets/card_swiper.dart';
import 'package:peliculas/src/widgets/movie_horizontal.dart';


class HomePage extends StatelessWidget {

  final peliculasProvider = PeliculasProvider();

  

  @override
  Widget build(BuildContext context) {



    

    return Scaffold(
      
      
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){

              showSearch(context: context,delegate: DataDelegate());
            },

          ),
        ],
        centerTitle: false,
        title: Text('Home Page'),
      ),
      
      
              body: Container(
          
         // height: 350.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _swiperTarjetas(),
              _footer(context),
              
            ],
          ),
        
      )
      //body: Container(color: Colors.blue,child: Text('Hola'),),
    
    );
  }
  Widget _swiperTarjetas(){
    
    return FutureBuilder(
      future: peliculasProvider.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {

        if (snapshot.data==null){
          return Container(
            height: 380.0,
            child: Center(child: CircularProgressIndicator()));
        }
        return CardSwiper(
          peliculas: snapshot.data,
        );
      },
    );
  }

  Widget _footer(BuildContext context) {
    peliculasProvider.getPopulares();

    return Container(
      //padding: EdgeInsets.only(bottom: 200),
      width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left:22.0),
              child: Text('Populares',style: Theme.of(context).textTheme.subhead),
            ),
            SizedBox(height: 9.0,),
             StreamBuilder(
                stream: peliculasProvider.popularesStream,
                builder: (BuildContext context, AsyncSnapshot <List> snapshot) {
                  
                  
                  

                  if(snapshot.hasData){
                    return MovieHorizontal(peliculas: snapshot.data, nextpage: peliculasProvider.getPopulares, );
                  }
                  else{
                    return Center(child: CircularProgressIndicator());

                  }
                  
                },
              ),
           
          ],
        ),
    );


  }
}
import 'package:flutter/material.dart';
import 'package:peliculas/providers/peliculas_provider.dart';
import 'package:peliculas/src/widgets/card_swiper.dart';


class HomePage extends StatelessWidget {

  final peliculasProvider = PeliculasProvider();

  Container blueC = new Container(
    color: Colors.blue,
  );
  Container yellowC = new Container(
    color: Colors.yellow,
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){},

          ),
        ],
        centerTitle: false,
        title: Text('Home Page'),
      ),
      body: Container(
        height: 350.0,
        child: _swiperTarjetas(),
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
            height: 400.0,
            child: Center(child: CircularProgressIndicator()));
        }
        return CardSwiper(
          peliculas: snapshot.data,
        );
      },
    );
  }
}
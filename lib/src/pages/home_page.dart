import 'package:flutter/material.dart';
import 'package:peliculas/src/widgets/card_swiper.dart';


class HomePage extends StatelessWidget {
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

    return CardSwiper(
      peliculas: [1,2,3,4,5],
    );
  }
}
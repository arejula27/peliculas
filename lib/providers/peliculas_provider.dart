
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:peliculas/src/models/pelicula_models.dart';

class PeliculasProvider{

  String _apikey='3725b34eb941d79716e452fd804777e7';
  String _url ='api.themoviedb.org';
  String _language = 'es-Es';
  int _peliculasPage =0;

  List<Pelicula> _populares=new List();

//creamos el stream, broadcast permite que haya más de un escuchante
  final _peliculasStreamController = StreamController<List<Pelicula>>.broadcast();

  //añadir elemtos al stram
  Function(List<Pelicula>)  get popularesSink=> _peliculasStreamController.sink.add;

  //obtener info del Stream
  Stream <List<Pelicula>> get popularesStream=>_peliculasStreamController.stream;


//funcin obligatoria para cerrar el stream
  void disposeStream(){
    _peliculasStreamController.close();
  }


  Future <List<Pelicula>> _procesarRespuesta(Uri url) async{

    final  resp = await  http.get(url);
     final decodeData = jsonDecode(resp.body);
     final peliculas = new Peliculas.fromJsonList(decodeData['results']);
  
    return peliculas.items;



  }


  Future <List<Pelicula>> getEnCines( )async{


      final url = Uri.https(_url, '3/movie/now_playing',{
        'api_key':_apikey,
        'languaje':_language,
      });


     return await _procesarRespuesta(url);
  }



  Future <List<Pelicula>> getPopulares()async{
    print("getPopulares");

    _peliculasPage ++;

      final url = Uri.https(_url, '3/movie/popular',{
        'api_key':_apikey,
        'languaje':_language,
        'page':_peliculasPage.toString()
      });

    final res =await _procesarRespuesta(url);

  if(res!=null){
    _populares.addAll(res);
    popularesSink(_populares);
  }
       
  
    return res;
  }
}






  










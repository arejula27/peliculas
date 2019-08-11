
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:peliculas/src/models/pelicula_models.dart';

class PeliculasProvider{

  String _apikey='3725b34eb941d79716e452fd804777e7';
  String _url ='api.themoviedb.org';
  String _language = 'es-Es';


  Future <List<Pelicula>> getEnCines()async{

      final url = Uri.https(_url, '3/movie/now_playing',{
        'api_key':_apikey,
        'languaje':_language,
      });


     final  resp = await  http.get(url);
     final decodeData = jsonDecode(resp.body);
     final peliculas = new Peliculas.fromJsonList(decodeData['results']);
  
    return peliculas.items;




  }



}
import 'package:flutter/material.dart';
import 'package:peliculas/src/pages/detalles_page.dart';
import 'package:peliculas/src/pages/home_page.dart';



 Map <String,WidgetBuilder> getAplicationRoutes(){
   return<String,WidgetBuilder>{
        '/'       : (BuildContext context)=>HomePage(),
        'detalles': (BuildContext context)=>Detalles(),
        
        };
      }
import 'package:flutter/material.dart';
import 'package:peliculas/src/pages/home_page.dart';
import 'package:peliculas/src/routes/rutas.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: '/',
      routes:getAplicationRoutes(),
      onGenerateRoute: (RouteSettings routeSettingd){

        print('ruta desconocida redireccionado a HomePage');
        return MaterialPageRoute(
          builder: (BuildContext contexte) => HomePage()
        );
      },
    );
  }
}
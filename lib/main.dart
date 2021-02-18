import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_bloc/pages/details_page.dart';
import 'package:prueba_bloc/pages/home_page.dart';


import 'app/bloc/product/products_bloc.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: ( _ ) => new ProductBloc() ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'home',
        routes: {
          'home': ( _ ) => HomePage(),
          'details': ( _ ) => DetailsPage(),
        },
      ),
    );
  }
}
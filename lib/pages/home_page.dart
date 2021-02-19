import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      body: Center(
        child: Text('No hay un usuario seleccionado'),
      ),

     floatingActionButton: FloatingActionButton(
       child: Icon( Icons.shopping_cart ),
       onPressed: () => Navigator.pushNamed(context, 'details')
     ),
   );
  }
}
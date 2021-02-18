import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pagina 1'),
        actions: [
          IconButton(
            icon: Icon( Icons.delete ), 
            onPressed: () {
            }
          )
        ],
      ),
      body: Center(
              child: Text('No hay un usuario seleccionado'),
      ),

     floatingActionButton: FloatingActionButton(
       child: Icon( Icons.accessibility_new ),
       onPressed: () => Navigator.pushNamed(context, 'details')
     ),
   );
  }
}
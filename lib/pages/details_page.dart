import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('details'),
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
       onPressed: () => Navigator.pushNamed(context, 'home')
     ),
   );
  }
}
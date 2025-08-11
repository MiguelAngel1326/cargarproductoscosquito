import 'package:flutter/material.dart';

class cargarProducto extends StatefulWidget {
  const cargarProducto({super.key});

  @override
  State<cargarProducto> createState() => _cargarProductoState();
}

class _cargarProductoState extends State<cargarProducto> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: const Text('Cargar Producto'),
      ),
      body: Center(
        child: Text('Cargar Producto Screen'),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MenuItem{
  final String title;
  final String subtitle;
  final String link;
  final IconData icon;

  const MenuItem({
  required this.title,
  required this.subtitle,
  required this.link,
  required this.icon, 
});
}

const appMenuItems = <MenuItem>[
  MenuItem(
    title: 'Cargar Producto',
    subtitle: 'Registrar nuevos productos',
    link: '/cargarProducto',
    icon: Icons.shopping_cart,
  ),
  MenuItem(
    title: 'Registrar Clientes',
    subtitle: 'Registrar nuevos clientes',
    link: '/registrarCliente',
    icon: Icons.person,
  ),
   MenuItem(
    title: 'Buscar Cliente',
    subtitle: 'Operaciones con cliente',
    link: '/operacionesCliente',
    icon: Icons.point_of_sale,
  ),
];

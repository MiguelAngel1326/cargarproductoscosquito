import 'package:cargaproductos/config/menu/menu_items.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Costquito GMZ'),
      ),
      body: _HomeView()
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {

    

    return ListView.builder(

      itemCount: appMenuItems.length,
      itemBuilder: (context, index){
        final menuItems = appMenuItems[index];
        return _CustomListTitle(menuItems: menuItems);
      }
    );
  }
}

class _CustomListTitle extends StatelessWidget {
  const _CustomListTitle({
    required this.menuItems,
  });

  final MenuItem menuItems;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(menuItems.icon),
      trailing: Icon(Icons.arrow_forward_ios_rounded),
      title: Text(menuItems.title),
      subtitle: Text(menuItems.subtitle),
      onTap: (){
        context.push(menuItems.link);
      },
    );
  }
}
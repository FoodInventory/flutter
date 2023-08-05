import 'package:flutter/material.dart';
import 'package:food_inventory/pages/add_page.dart';
import 'package:food_inventory/pages/home_page.dart';
import 'package:food_inventory/pages/inventory_page.dart';
import 'package:food_inventory/pages/settings_page.dart';

class AppMenu extends StatefulWidget {
  const AppMenu({super.key, required this.title});

  final String title;

  @override
  State<AppMenu> createState() => AppMenuState();
}

class AppMenuState extends State<AppMenu> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          elevation: 20,
          centerTitle: mounted,
        ),
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          selectedIndex: currentPageIndex,
          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: Icon(Icons.home_rounded),
              icon: Icon(Icons.home_outlined),
              label: 'Accueil',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.list_rounded),
              icon: Icon(Icons.list_outlined),
              label: 'Liste',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.add_rounded),
              icon: Icon(Icons.add_outlined),
              label: 'Ajouter',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.settings_rounded),
              icon: Icon(Icons.settings_outlined),
              label: 'Paramètres',
            )
          ],
        ),
        body: <Widget>[
          const HomePage(),
          const InventoryPage(),
          const AddPage(),
          const SettingsPage()
        ][currentPageIndex]);
  }
}

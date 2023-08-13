import 'package:flutter/material.dart';
import 'package:food_inventory/components/produit_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 100),
      child: Column(
        children: [
          Card(
            child: SizedBox(
              height: 100,
              child: Center(
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProduitList(),
                      ),
                    );
                  },
                  title: const Text(
                    'Liste de la cave',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  leading: const Icon(
                    Icons.home_rounded,
                    size: 40,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Card(
            child: SizedBox(
              height: 100,
              child: Center(
                child: ListTile(
                  title: Text(
                    'Liste des courses',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  leading: Icon(
                    Icons.shopping_bag_rounded,
                    size: 40,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Card(
            child: SizedBox(
              height: 100,
              child: Center(
                child: ListTile(
                  title: Text(
                    'Liste de trucs',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  leading: Icon(
                    Icons.onetwothree_sharp,
                    size: 40,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Card(
            child: SizedBox(
              height: 100,
              child: Center(
                child: ListTile(
                  title: Text(
                    'Liste de machins',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  leading: Icon(
                    Icons.table_restaurant_rounded,
                    size: 40,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Card(
            child: SizedBox(
              height: 100,
              child: Center(
                child: ListTile(
                  title: Text(
                    'Liste de bidules',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  leading: Icon(
                    Icons.weekend_sharp,
                    size: 40,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

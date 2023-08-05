import 'package:flutter/material.dart';

class ProduitView extends StatefulWidget {
  const ProduitView({super.key});

  @override
  State<StatefulWidget> createState() => _ProduitViewState();
}

class _ProduitViewState extends State<ProduitView> {
  @override
  Widget build(BuildContext context) {
    // return a list of created sample products;
    return ListView(
      children: <Widget>[
        createSampleProduit(),
        createSampleProduit(),
        createSampleProduit(),
        createSampleProduit(),
        createSampleProduit(),
        createSampleProduit(),
        createSampleProduit(),
        createSampleProduit(),
      ],
    );
  }

  Card createSampleProduit() {
    return Card(
      child: ListTile(
        leading: Image.network(
            "https://images.openfoodfacts.org/images/products/327/408/000/5003/front_fr.950.full.jpg"),
        title: const Text('Eau de source - Cristaline'),
        subtitle: const Text('Quantite: 1.5L\nNombre: 6'),
        trailing: const Icon(Icons.more_vert),
        isThreeLine: true,
      ),
    );
  }
}

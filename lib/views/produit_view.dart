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
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          contentPadding: const EdgeInsets.all(0.0),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              "https://images.openfoodfacts.org/images/products/327/408/000/5003/front_fr.950.full.jpg",
              height: 80,
              width: 50,
              fit: BoxFit.cover,
            ),
          ),
          title: const Text(
            'Eau de source - Cristaline',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 4),
              Text(
                'Quantité: 1.5L',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              Text(
                'Nombre: 6',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ],
          ),
          trailing: IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // Edit menu
            },
          ),
        ),
      ),
    );
  }
}

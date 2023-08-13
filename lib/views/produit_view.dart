import 'package:flutter/material.dart';
import 'package:food_inventory/components/produit_card.dart';
import 'package:food_inventory/models/produit.dart';
import 'package:food_inventory/services/produit_service.dart';

class ProduitView extends StatefulWidget {
  const ProduitView({super.key});

  @override
  State<StatefulWidget> createState() => _ProduitViewState();
}

class _ProduitViewState extends State<ProduitView> {
  final ProduitService produitService = ProduitService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Produit>>(
      future: produitService.getProducts(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              Produit produit = Produit(
                nom: snapshot.data![index].nom,
                barcode: snapshot.data![index].barcode,
                marque: snapshot.data![index].marque,
                image: snapshot.data![index].image,
                quantite: snapshot.data![index].quantite,
                nombre: snapshot.data![index].nombre,
              );
              return ProduitCard(produit: produit);
            },
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const CircularProgressIndicator();
      },
    );
  }
}

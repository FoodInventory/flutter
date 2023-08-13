import 'package:flutter/material.dart';
import 'package:food_inventory/components/produit_card.dart';
import 'package:food_inventory/models/produit.dart';

class ProduitList extends StatefulWidget {
  const ProduitList({super.key});

  @override
  State<ProduitList> createState() => _ProduitListState();
}

class _ProduitListState extends State<ProduitList> {
  @override
  Widget build(BuildContext context) {
    Produit sampleProduit = Produit(
        barcode: BigInt.from(1111),
        nom: "Truc",
        marque: "Machin",
        quantite: '200g',
        image: "https://picsum.photos/250?image=9");
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return ProduitCard(produit: sampleProduit);
      },
    );
  }
}

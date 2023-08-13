import 'package:flutter/material.dart';
import 'package:food_inventory/views/produit_view.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  @override
  Widget build(BuildContext context) {
    return const ProduitView();
  }
}

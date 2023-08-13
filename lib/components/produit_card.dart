import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:food_inventory/models/produit.dart';
import 'package:food_inventory/services/produit_service.dart';

class ProduitCard extends StatefulWidget {
  final Produit produit;

  const ProduitCard({super.key, required this.produit});

  @override
  State<ProduitCard> createState() => _ProduitCardState();
}

class _ProduitCardState extends State<ProduitCard> {
  @override
  Widget build(BuildContext context) {
    Color accentColor = Theme.of(context).colorScheme.secondaryContainer;

    TextEditingController nomController = TextEditingController();
    TextEditingController marqueController = TextEditingController();
    TextEditingController quantiteController = TextEditingController();
    TextEditingController nombreController = TextEditingController();

    return badges.Badge(
      badgeContent: Text(
        widget.produit.nombre > 99 ? '99+' : widget.produit.nombre.toString(),
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      badgeStyle: badges.BadgeStyle(
        badgeColor: accentColor,
        padding: const EdgeInsets.all(5.0),
      ),
      position: BadgePosition.topEnd(top: 0, end: 0),
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: ListTile(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    scrollable: true,
                    title: const Text('Détails du produit'),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              widget.produit.image!,
                              height: 80,
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            '${widget.produit.marque} ${widget.produit.nom}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 4),
                              Text(
                                'Quantité: ${widget.produit.quantite}',
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                'Nombre: ${widget.produit.nombre}',
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            nomController.text = widget.produit.nom!;
                            marqueController.text = widget.produit.marque!;
                            quantiteController.text = widget.produit.quantite!;
                            nombreController.text =
                                widget.produit.nombre.toString();
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  scrollable: true,
                                  title: const Text('Modifier'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextField(
                                        controller: nomController,
                                        decoration: const InputDecoration(
                                          labelText: 'Nom',
                                        ),
                                      ),
                                      TextField(
                                        controller: marqueController,
                                        decoration: const InputDecoration(
                                          labelText: 'Marque',
                                        ),
                                        keyboardType: TextInputType.number,
                                      ),
                                      TextField(
                                        controller: quantiteController,
                                        decoration: const InputDecoration(
                                          labelText: 'Quantité',
                                        ),
                                      ),
                                      TextField(
                                        controller: nombreController,
                                        decoration: const InputDecoration(
                                          labelText: 'Nombre',
                                        ),
                                        keyboardType: TextInputType.number,
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Annuler'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Produit newProduit = Produit(
                                          barcode: widget.produit.barcode,
                                          categorie: widget.produit.categorie,
                                          nom: nomController.text,
                                          marque: marqueController.text,
                                          quantite: quantiteController.text,
                                          nombre:
                                              int.parse(nombreController.text),
                                          image: widget.produit.image,
                                        );
                                        ProduitService.updateProduit(newProduit)
                                            .then((response) {});
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Modifier'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: const Text('Modifier')),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Fermer'),
                      ),
                    ],
                  );
                },
              );
            },
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                widget.produit.image!,
                height: 80,
                width: 50,
                fit: BoxFit.cover,
              ),
            ),
            contentPadding: const EdgeInsets.all(0.0),
            title: Text(
              '${widget.produit.marque} ${widget.produit.nom}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(
                  widget.produit.quantite!,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

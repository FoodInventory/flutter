import 'package:flutter/material.dart';

class ProduitCard extends StatefulWidget {
  final String nom;
  final String marque;
  final String image;
  final String quantite;
  final int nombre;

  const ProduitCard(
      {super.key,
      required this.nom,
      required this.marque,
      required this.image,
      required this.quantite,
      required this.nombre});

  @override
  State<ProduitCard> createState() => _ProduitCardState();
}

class _ProduitCardState extends State<ProduitCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          onTap: () {
            // show ListTile details in an AlertDialog with ListTile content and image
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
                            widget.image,
                            height: 80,
                            width: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                          '${widget.marque} ${widget.nom}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 4),
                            Text(
                              'Quantité: ${widget.quantite}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              'Nombre: ${widget.nombre}',
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
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                scrollable: true,
                                title: const Text('Modifier'),
                                content: const Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextField(
                                      decoration: InputDecoration(
                                        labelText: 'Nom',
                                      ),
                                    ),
                                    TextField(
                                      decoration: InputDecoration(
                                        labelText: 'Quantité',
                                      ),
                                      keyboardType: TextInputType.number,
                                    ),
                                    TextField(
                                      decoration: InputDecoration(
                                        labelText: 'Unité',
                                      ),
                                    ),
                                    TextField(
                                      decoration: InputDecoration(
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
          // add a badge for the number of products
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              widget.image,
              height: 80,
              width: 50,
              fit: BoxFit.cover,
            ),
          ),
          contentPadding: const EdgeInsets.all(0.0),
          title: Text(
            '${widget.marque} ${widget.nom}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ProduitCard extends StatefulWidget {
  final String nom;
  final String image;
  final double quantite;
  final String unite;
  final int nombre;

  const ProduitCard(
      {super.key,
      required this.nom,
      required this.image,
      required this.quantite,
      required this.unite,
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
            contentPadding: const EdgeInsets.all(0.0),
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
              widget.nom,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(
                  'Quantité: ${widget.quantite} ${widget.unite}',
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
            trailing: IconButton(
              icon: const Icon(Icons.edit),
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
            )),
      ),
    );
  }
}

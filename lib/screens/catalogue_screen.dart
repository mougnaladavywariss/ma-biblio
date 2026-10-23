import 'package:flutter/material.dart';

import '../models/livre.dart';
import '../data/livres_data.dart';

class CatalogueScreen extends StatelessWidget {
  const CatalogueScreen({super.key});

  Widget _livreTile(Livre livre) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: livre.couleur,
        child: Text(
          livre.titre.isNotEmpty ? livre.titre[0].toUpperCase() : '',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      title: Text(
        livre.titre,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Text('${livre.auteur} – ${livre.annee}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            livre.note.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(width: 4),
          const Icon(Icons.star, color: Colors.amber, size: 20),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final nouveautes = livres.where((livre) => livre.nouveaute).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Catalogue des livres')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Text(
              'Nouveautés',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 160,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: nouveautes.length,
              itemBuilder: (context, index) {
                final livre = nouveautes[index];
                return Container(
                  width: 110,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: livre.couleur,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        livre.titre,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const Divider(height: 24),
          // Titre section Tout le catalogue
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: Text(
              'Tout le catalogue',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: livres.length,
              separatorBuilder: (context, index) => const Divider(indent: 72),
              itemBuilder: (context, index) {
                return _livreTile(livres[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

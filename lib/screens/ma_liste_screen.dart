import 'package:flutter/material.dart';

import '../models/livre.dart';
import '../data/livres_data.dart';

class MaListeScreen extends StatefulWidget {
  const MaListeScreen({super.key});

  @override
  State<MaListeScreen> createState() => _MaListeScreenState();
}

class _MaListeScreenState extends State<MaListeScreen> {
  bool _nouveautesSeulement = false;

  final Map<String, bool> _genres = {
    'Jeunesse': true,
    'Roman': true,
    'Science': true,
    'Histoire': true,
    'Informatique': true,
  };

  bool? get _tousLesGenresValue {
    if (_genres.values.every((v) => v)) return true;
    if (_genres.values.every((v) => !v)) return false;
    return null;
  }

  IconData _getIconeGenre(String genre) {
    switch (genre) {
      case 'Science':
        return Icons.science;
      case 'Informatique':
        return Icons.computer;
      case 'Histoire':
        return Icons.history;
      case 'Jeunesse':
        return Icons.child_care;
      default:
        return Icons.menu_book;
    }
  }

  @override
  Widget build(BuildContext context) {
    final livresFiltres = livres.where((livre) {
      bool genreCoche = _genres[livre.genre] ?? false;
      bool respecteNouveaute = !_nouveautesSeulement || livre.nouveaute;
      return genreCoche && respecteNouveaute;
    }).toList();

    int xLus = livresFiltres.where((l) => l.lu).length;
    int yTotal = livresFiltres.length;

    return Scaffold(
      appBar: AppBar(title: Text('Ma liste – Lus : $xLus / $yTotal')),
      body: ListView(
        children: [
          CheckboxListTile(
            title: const Text('Afficher uniquement les nouveautés'),
            value: _nouveautesSeulement,
            onChanged: (bool? value) {
              setState(() {
                _nouveautesSeulement = value ?? false;
              });
            },
          ),
          const Divider(),

          CheckboxListTile(
            title: const Text('Tous les genres'),
            tristate: true,
            value: _tousLesGenresValue,
            onChanged: (bool? value) {
              setState(() {
                bool newVal = value ?? false;
                _genres.updateAll((key, _) => newVal);
              });
            },
          ),
          const Divider(),

          ..._genres.keys.map((genre) {
            int nombreLivres = livres.where((l) => l.genre == genre).length;

            return CheckboxListTile(
              title: Text(genre),
              subtitle: Text('$nombreLivres livres'),
              secondary: Icon(_getIconeGenre(genre)),
              activeColor: Colors.blue,
              controlAffinity: ListTileControlAffinity.leading,
              value: _genres[genre],
              onChanged: (bool? value) {
                setState(() {
                  _genres[genre] = value ?? false;
                });
              },
            );
          }).toList(),

          const Divider(thickness: 2),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Livres filtrés :',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),

          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: livresFiltres.length,
            separatorBuilder: (context, index) =>
                const Divider(indent: 16, endIndent: 16),
            itemBuilder: (context, index) {
              final livre = livresFiltres[index];
              return CheckboxListTile(
                title: Text(
                  livre.titre,
                  style: TextStyle(
                    decoration: livre.lu
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    color: livre.lu ? Colors.grey : Colors.black,
                  ),
                ),
                subtitle: Text('${livre.auteur} (${livre.annee})'),
                value: livre.lu,
                onChanged: (bool? value) {
                  setState(() {
                    livre.lu = value ?? false;
                  });
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

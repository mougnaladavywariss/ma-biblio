import 'package:flutter/material.dart';

import 'models/livre.dart';
import 'data/livres_data.dart';
import 'screens/parametres_screen.dart';

void main() {
  runApp(const MaBiblioApp());
}

class MaBiblioApp extends StatelessWidget {
  const MaBiblioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'MaBiblio',
      debugShowCheckedModeBanner: false,
      useMaterial3: true,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget livreTile(Livre livre) {
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
    final troisPremiersLivres = livresList.take(3).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('MaBiblio - Accueil'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Paramètres',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ParametresScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Mes 3 premiers livres :',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          ...troisPremiersLivres.map((livre) => livreTile(livre)),
        ],
      ),
    );
  }
}

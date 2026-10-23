import 'package:flutter/material.dart';

import 'models/livre.dart';
import 'services/livre_service.dart';
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
      home: HomeLoader(),
    );
  }
}

class HomeLoader extends StatelessWidget {
  const HomeLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Livre>>(
      future: LivreService.chargerLivres(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text(
                'Erreur de chargement : ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            ),
          );
        } else {
          // Données chargées avec succès
          final livres = snapshot.data!;
          return HomePage(livres: livres);
        }
      },
    );
  }
}

class HomePage extends StatefulWidget {
  final List<Livre> livres;

  const HomePage({super.key, required this.livres});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final troisPremiersLivres = widget.livres.take(3).toList();

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

          ...troisPremiersLivres.map(
            (livre) => ListTile(
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
              title: Text(livre.titre),
              subtitle: Text(livre.auteur),
            ),
          ),
        ],
      ),
    );
  }
}

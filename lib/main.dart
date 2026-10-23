import 'package:flutter/material.dart';

import 'models/livre.dart';
import 'services/livre_service.dart';
import 'screens/parametres_screen.dart';
import 'screens/catalogue_screen.dart';
import 'screens/galerie_screen.dart';
import 'screens/ma_liste_screen.dart';

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
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> ecrans = [
      CatalogueScreen(livres: widget.livres),
      GalerieScreen(livres: widget.livres),
      MaListeScreen(livres: widget.livres),
    ];

    return Scaffold(
      body: ecrans[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          LivreService.sauvegarderLivres(widget.livres);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Catalogue'),
          BottomNavigationBarItem(icon: Icon(Icons.grid_on), label: 'Galerie'),
          BottomNavigationBarItem(
            icon: Icon(Icons.checklist),
            label: 'Ma liste',
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../models/livre.dart';
import '../widgets/livre_grid_item.dart';
import '../widgets/livre_card.dart';
import 'detail_screen.dart';

class GalerieScreen extends StatefulWidget {
  final List<Livre> livres;

  const GalerieScreen({super.key, required this.livres});

  @override
  State<GalerieScreen> createState() => _GalerieScreenState();
}

class _GalerieScreenState extends State<GalerieScreen> {
  bool _isGridView = true;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    int crossAxisCount = width > 900 ? 4 : (width > 600 ? 3 : 2);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Galerie des livres'),
        actions: [
          IconButton(
            icon: const Icon(Icons.sort),
            tooltip: 'Trier par note',
            onPressed: () {
              setState(() {
                widget.livres.sort((a, b) => b.note.compareTo(a.note));
              });
            },
          ),
          IconButton(
            icon: Icon(_isGridView ? Icons.view_list : Icons.grid_view),
            tooltip: 'Changer d\'affichage',
            onPressed: () {
              setState(() {
                _isGridView = !_isGridView;
              });
            },
          ),
        ],
      ),
      body: _isGridView
          ? GridView.builder(
              itemCount: widget.livres.length,
              padding: const EdgeInsets.all(12),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                childAspectRatio: 0.7,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
              ),
              itemBuilder: (context, index) {
                final livre = widget.livres[index];
                return LivreGridItem(
                  livre: livre,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(livre: livre),
                      ),
                    ).then((_) => setState(() {}));
                  },
                );
              },
            )
          : ListView.builder(
              itemCount: widget.livres.length,
              itemBuilder: (context, index) {
                final livre = widget.livres[index];
                return LivreCard(
                  livre: livre,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(livre: livre),
                      ),
                    ).then((_) => setState(() {}));
                  },
                );
              },
            ),
    );
  }
}

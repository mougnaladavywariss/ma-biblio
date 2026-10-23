import 'package:flutter/material.dart';

import '../models/livre.dart';

class DetailScreen extends StatefulWidget {
  final Livre livre;

  const DetailScreen({super.key, required this.livre});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.livre.titre)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 200,
                color: widget.livre.couleur,
                padding: const EdgeInsets.all(16),
                alignment: Alignment.center,
                child: Text(
                  widget.livre.titre,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Auteur'),
                subtitle: Text(widget.livre.auteur),
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.calendar_today),
                title: const Text('Année de parution'),
                subtitle: Text('${widget.livre.annee}'),
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.category),
                title: const Text('Genre'),
                subtitle: Text(widget.livre.genre),
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.star, color: Colors.amber),
                title: const Text('Note'),
                subtitle: Text('${widget.livre.note} / 5'),
              ),
              const Padding(padding: EdgeInsets.all(16.0), child: Divider()),
              OverflowBar(
                alignment: MainAxisAlignment.spaceAround,
                spacing: 8,
                overflowAlignment: OverflowBarAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        widget.livre.favori = !widget.livre.favori;
                      });
                    },
                    icon: Icon(
                      widget.livre.favori
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: widget.livre.favori ? Colors.red : null,
                    ),
                    label: Text(
                      widget.livre.favori ? 'Favoris' : 'Ajouter aux favoris',
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        widget.livre.lu = !widget.livre.lu;
                      });
                    },
                    icon: Icon(
                      widget.livre.lu
                          ? Icons.check_circle
                          : Icons.circle_outlined,
                    ),
                    label: Text(
                      widget.livre.lu ? 'Marqué comme lu' : 'Marquer comme lu',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

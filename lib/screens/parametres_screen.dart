import 'package:flutter/material.dart';

import '../services/livre_service.dart';

class ParametresScreen extends StatelessWidget {
  const ParametresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Paramètres')),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Mon profil'),
            subtitle: const Text('Nom, e-mail, mot de passe'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profil sélectionné')),
              );
            },
          ),

          const Divider(),

          ListTile(
            tileColor: Colors.blue.shade50,
            iconColor: Colors.blue.shade700,
            textColor: Colors.blue.shade900,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            leading: const Icon(Icons.notifications),
            title: const Text('Notifications'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Notifications sélectionnées')),
              );
            },
          ),

          const Divider(),

          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Langue'),
            subtitle: const Text('Français'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Langue sélectionnée')),
              );
            },
          ),

          const Divider(),

          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('À propos'),
            subtitle: const Text('Version 1.0.0\nTous droits réservés'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('À propos sélectionné')),
              );
            },
          ),

          const Divider(),

          ListTile(
            leading: const Icon(Icons.restart_alt, color: Colors.red),
            title: const Text(
              'Réinitialiser ma bibliothèque',
              style: TextStyle(color: Colors.red),
            ),
            subtitle: const Text(
              'Supprime les modifications et recharge les données d\'origine',
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Confirmation'),
                  content: const Text(
                    'Voulez-vous vraiment réinitialiser votre bibliothèque ?',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Annuler'),
                    ),
                    TextButton(
                      onPressed: () async {
                        await LivreService.reinitialiserBibliotheque();
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Bibliothèque réinitialisée ! Relancez l\'application.',
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        'Confirmer',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ParametresScreen extends StatelessWidget {
  const ParametresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Paramètres')),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: ListTile.divideTiles(
          context: context,
          tiles: [
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
          ],
        ).toList(),
      ),
    );
  }
}

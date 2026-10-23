import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import '../models/livre.dart';

class LivreService {
  static const String _fileName = 'mabiblio.json';

  static Future<File> get _localFile async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/$_fileName');
  }

  static Future<List<Livre>> chargerLivres() async {
    try {
      final file = await _localFile;
      String jsonString;

      if (await file.exists()) {
        jsonString = await file.readAsString();
      } else {
        jsonString = await rootBundle.loadString('assets/livres.json');
      }

      List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.map((json) => Livre.fromJson(json)).toList();
    } catch (e) {
      String jsonString = await rootBundle.loadString('assets/livres.json');
      List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.map((json) => Livre.fromJson(json)).toList();
    }
  }

  static Future<void> sauvegarderLivres(List<Livre> livres) async {
    final file = await _localFile;
    final jsonList = livres.map((l) => l.toJson()).toList();
    await file.writeAsString(jsonEncode(jsonList));
  }

  static Future<void> reinitialiserBibliotheque() async {
    final file = await _localFile;
    if (await file.exists()) {
      await file.delete();
    }
  }
}

import 'package:path_provider/path_provider.dart';
import 'dart:io';
class CounterStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/counter.txt');
  }

// Leer archivo la primera vez que se ejecuta el archivo
  Future<String> readCounter() async {
    String count = '0';
    try {
      final file = await _localFile;
      String contents = await file.readAsString();
      return contents;
    } catch (e) {
      // Si el documento no esta escrito, regresamos 0
      return '0';
      print('valor de : $count');
    }
    return count;
  }

  Future<File> writeCounter(String counter) async {
    final file = await _localFile;

    // Escribir archivo
    return file.writeAsString('$counter');
  }
}
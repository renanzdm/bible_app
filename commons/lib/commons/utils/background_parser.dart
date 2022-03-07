import 'dart:convert';
import 'dart:isolate';

class BackgroundParser {
  final String stringJson;
  BackgroundParser({
    required this.stringJson,
  });
 Future<dynamic>  createIsolateConfigureBoxBible() async {
    final ReceivePort port = ReceivePort();
    await Isolate.spawn(_readJsonFile, port.sendPort);
    return await port.first;
  }

  _readJsonFile(SendPort port) async {
    var json = jsonDecode(stringJson);
    Isolate.exit(port, json);
  }
}
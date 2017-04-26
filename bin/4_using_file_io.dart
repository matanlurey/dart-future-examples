import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

/// Prints {name: Joe User}, {name: Joe User}, and {name: Joe User}.
main() async {
  // Reads and decodes a file synchronously.
  print(readSync());

  // Reads a file asynchronously and then decodes it.
  print(await readAsync());

  // Reads a file synchronously in other isolate and then decodes it.
  print(await readIsolate());
}

/// Reads 'file.json' synchronously (in the same thread).
Map readSync() => JSON.decode(new File('file.json').readAsStringSync());

/// Reads 'file.json' asynchronously (in another thread managed by the VM).
Future<Map> readAsync() async {
  return JSON.decode(await new File('file.json').readAsString());
}

/// Reads 'file.json' synchronously in another isolate, similar to readAsync.
Future<Map> readIsolate() async {
  final response = new ReceivePort();
  await Isolate.spawn(_isolate, response.sendPort);
  return response.first;
}

/// Expected to be created via [Isolate.spawn].
void _isolate(SendPort sendPort) {
  sendPort.send(readSync());
}

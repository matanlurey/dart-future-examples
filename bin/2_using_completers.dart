import 'dart:async';

main() {
  final completer = new Completer<String>();
  completer.future.then(print);
  completer.complete('Hello World');
}

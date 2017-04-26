import 'dart:async';

// Prints: "1", "4", "2", and "3".
main() {
  print('1');
  getInFuture2().then(print);
  getInFuture3().then(print);
  print('4');
}

Future<String> getInFuture2() => new Future.value('2');

Future<String> getInFuture3() => new Future.delayed(Duration.ZERO, () => '3');

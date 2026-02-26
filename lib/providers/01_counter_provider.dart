import 'package:riverpod_annotation/riverpod_annotation.dart';

part '01_counter_provider.g.dart';

@riverpod
class Counter extends _$Counter {
  @override
  int build() {
    return 0;
  }

  void increment() => state++;
  void decrement() => state--;
  void reset() => state = 0;
}
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'riverpod_basic_provider.g.dart';

@riverpod
String riverpodBasicPageTemplate(Ref ref) {
  return "这是一段由Riverpod提供的字符串";
}

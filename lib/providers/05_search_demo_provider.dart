import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'dart:async';

part '05_search_demo_provider.g.dart';

@riverpod
class SearchQuery extends _$SearchQuery {
  @override
  String build() {
    return '';
  }

  void updateSearchQuery(String query) {
    state = query;
  }
}

@riverpod
class SearchResults extends _$SearchResults {
  Timer? _debounceTimer;
  
  @override
  Future<List<String>> build() async {
    final query = ref.watch(searchQueryProvider);

    // 监听变化, 取消定时器
    ref.onDispose(() => _debounceTimer?.cancel());

    if (query.isEmpty) {
      return [];
    }

    await Future.delayed(Duration(microseconds: 500));

    await Future.delayed(Duration(seconds: 1));

    return[
      '$query结果1',
      '$query结果2',
      '$query结果3'
    ];
  }
}
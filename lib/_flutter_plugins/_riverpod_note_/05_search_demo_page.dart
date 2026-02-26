import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application/providers/05_search_demo_provider.dart';

@RoutePage()
class SearchDemoPage extends ConsumerWidget {
  const SearchDemoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref.watch(searchQueryProvider);
    final resultsAsync = ref.watch(searchResultsProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('fucking search page...'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'just type in something...',
                prefix: Icon(Icons.search),
                border: OutlineInputBorder()
              ),
              onChanged: (value) {
                ref.read(searchQueryProvider.notifier).updateSearchQuery(value);
              },
            ),
          ),
          Expanded(
            child: resultsAsync.when(
              loading: () => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 10),
                    Text('searching...[$query]')
                  ],
                ),
              ),
              error: (error, stack) => Center(child: Text('error: $error')), 
              data: (results) {
                if (results.isEmpty && query.isNotEmpty) {
                  return Center(child: Text('No results!!!'));
                }
                if (results.isEmpty) {
                  return Center(child: Text('just type in something'));
                }
                return ListView.builder(
                  itemCount: results.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Icon(Icons.search),
                      title: Text(results[index]),
                    );
                  },
                );
              }, 
            ),
          )
        ],
      ),
    );
  }
}
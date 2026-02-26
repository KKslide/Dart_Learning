import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application/providers/04_api_req_provider.dart';

@RoutePage()
class ApiReqPage extends ConsumerWidget {
  const ApiReqPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersAsync = ref.watch(usersListProvider);

    return Scaffold(
      appBar: AppBar(title: Text('fake api request')),
      body: usersAsync.when(
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('err==>>> $error'),
              ElevatedButton(onPressed: () {}, child: Text('try again')),
            ],
          ),
        ),
        data: (users) => RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(usersListProvider);
          },
          child: ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              
              return ListTile(
                leading: CircleAvatar(
                  child: Text(user['name'][0]),
                ),
                title: Text(user['name']),
                subtitle: Text(user['email']),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => UserDetailPage(userId: user['id']),
                    ),
                  );
                },
              );
            }
          ),
        ),
      ),
    );
  }
}

class UserDetailPage extends ConsumerWidget {
  
  final String userId;

  const UserDetailPage({super.key, required this.userId});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userDetailProvider(userId));
    
    return Scaffold(
      appBar: AppBar(
        title: Text('The Detail...'),
      ),
      body: userAsync.when(
        loading: ()=>Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('err==>>> $error')),
        data: (user) => Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('ID: ${user["id"]}'),
              Divider(),
              Text('NAME: ${user["name"]}'),
              Divider(),
              Text('EMAIL: ${user['email']}'),
            ],
          ),
        ),
      ),
    );
  }
}
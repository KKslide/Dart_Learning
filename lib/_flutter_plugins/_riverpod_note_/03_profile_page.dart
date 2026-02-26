import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application/providers/03_profile_provider.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final isLoggedIn = ref.watch(isLoggedInProvider);
    // print('user $user ||| $isLoggedIn');

    if (!isLoggedIn) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Log in Demo'),
        ),
        body: Center(
          child: ElevatedButton(onPressed: 
          () {
            ref.read(currentUserProvider.notifier).login(
              'lyk', 
              'kangyouknowwho@qq.com', 
              36
            );
          }, child: Text('模拟登陆')),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Log in Demo'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('用户ID: ${user!.id}'),
            SizedBox(height: 10),
            Text('用户名: ${user.name}'),
            SizedBox(height: 10),
            Text('用户年龄: ${user.age}'),
            SizedBox(height: 10),
            Text('用户Email: ${user.email}'),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                ref.read(currentUserProvider.notifier).updateEmail('newemail@example.com');
              },
              child: Text('更新邮箱')
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                ref.read(currentUserProvider.notifier).logout();
              }, 
              child: Text('登出')
            )
          ],
        ),
      )
    ); 
    
  }
}
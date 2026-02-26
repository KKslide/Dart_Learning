import 'package:riverpod_annotation/riverpod_annotation.dart';

part '03_profile_provider.g.dart';

class User {
  final String id;
  final String name;
  final String email;
  final int age;
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.age,
  });

  // 用于不可变更新
  User copyWith({
    String? id,
    String? name,
    String? email,
    int? age
  }) {
    return User(
      id: id ??  this.id,
      name: name ??  this.name,
      email: email ??  this.email,
      age: age ??  this.age,
    );
  }
}

@riverpod
class CurrentUser extends _$CurrentUser {
  @override
  User? build() {
    return null;
  }

  // 模拟登陆
  void login(String name, String email, int age) {
    state = User(
      id: DateTime.now().microsecondsSinceEpoch.toString(), 
      name: name, 
      email: email, 
      age: age
    );
  }

  // 模拟更新Email
  void updateEmail(String newEmail) {
    if (state != null) {
      state = state!.copyWith(email: newEmail);
    }
  }

  // 模拟退出登录
  void logout() {
    state = null;
  }
  
}

// 计算属性, 类似 pinia的 getters
@riverpod
bool isLoggedIn(Ref ref) {
  final user = ref.watch(currentUserProvider);
  return user != null;
}

@riverpod
String userDisplayName (Ref ref) {
  final user = ref.watch(currentUserProvider);
  return user?.name ?? '未登录';
}
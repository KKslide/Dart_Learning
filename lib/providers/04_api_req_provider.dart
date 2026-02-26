import 'package:riverpod_annotation/riverpod_annotation.dart';

part '04_api_req_provider.g.dart';

class ApiService {
  // 模拟API请求
  Future<List<Map<String, dynamic>>> fetchUsers() async {
    await Future.delayed(Duration(seconds: 2));

    return [
      { "id": '1', 'name':'陈浩南', 'email': 'chn@dx.hk' },
      { "id": '2', 'name':'山鸡', 'email': 'sj@dx.hk' },
      { "id": '3', 'name':'大天二', 'email': 'dte@dx.hk' },
    ];
  }

  // 通过id找用户
  Future fetchUserById(String id) async {
    await Future.delayed(Duration(seconds: 2));

    return { 'id': id, 'name': '用户$id', 'email': 'user$id@example.com' };
  }
}

// 单例服务
@riverpod
ApiService apiService(Ref ref) => ApiService();

// FutureProvider - 获取用户列表
@riverpod
Future<List<Map<String, dynamic>>> usersList(Ref ref) async { // UsersListRef
  final api = ref.watch(apiServiceProvider);
  return api.fetchUsers();
}

// 带参数的Provider - 获取单个用户
@riverpod
Future userDetail(Ref ref, String userId) async {
  final api = ref.watch(apiServiceProvider);
  return api.fetchUserById(userId);
}
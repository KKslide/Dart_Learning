// GENERATED CODE - DO NOT MODIFY BY HAND

part of '04_api_req_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(apiService)
const apiServiceProvider = ApiServiceProvider._();

final class ApiServiceProvider
    extends $FunctionalProvider<ApiService, ApiService, ApiService>
    with $Provider<ApiService> {
  const ApiServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'apiServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$apiServiceHash();

  @$internal
  @override
  $ProviderElement<ApiService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ApiService create(Ref ref) {
    return apiService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ApiService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ApiService>(value),
    );
  }
}

String _$apiServiceHash() => r'01c3d99362f3730b98e29079977950009cd07601';

@ProviderFor(usersList)
const usersListProvider = UsersListProvider._();

final class UsersListProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Map<String, dynamic>>>,
          List<Map<String, dynamic>>,
          FutureOr<List<Map<String, dynamic>>>
        >
    with
        $FutureModifier<List<Map<String, dynamic>>>,
        $FutureProvider<List<Map<String, dynamic>>> {
  const UsersListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'usersListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$usersListHash();

  @$internal
  @override
  $FutureProviderElement<List<Map<String, dynamic>>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Map<String, dynamic>>> create(Ref ref) {
    return usersList(ref);
  }
}

String _$usersListHash() => r'2e5508b8c35efa72fe5a845704fbd753851120e8';

@ProviderFor(userDetail)
const userDetailProvider = UserDetailFamily._();

final class UserDetailProvider
    extends $FunctionalProvider<AsyncValue<dynamic>, dynamic, FutureOr<dynamic>>
    with $FutureModifier<dynamic>, $FutureProvider<dynamic> {
  const UserDetailProvider._({
    required UserDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'userDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$userDetailHash();

  @override
  String toString() {
    return r'userDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<dynamic> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<dynamic> create(Ref ref) {
    final argument = this.argument as String;
    return userDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is UserDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$userDetailHash() => r'910ccc4ee48c622047772da5ca58d067637a6766';

final class UserDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<dynamic>, String> {
  const UserDetailFamily._()
    : super(
        retry: null,
        name: r'userDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  UserDetailProvider call(String userId) =>
      UserDetailProvider._(argument: userId, from: this);

  @override
  String toString() => r'userDetailProvider';
}

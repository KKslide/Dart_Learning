// GENERATED CODE - DO NOT MODIFY BY HAND

part of '06_todo_demo_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TodoList)
const todoListProvider = TodoListProvider._();

final class TodoListProvider
    extends $AsyncNotifierProvider<TodoList, List<Todo>> {
  const TodoListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'todoListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$todoListHash();

  @$internal
  @override
  TodoList create() => TodoList();
}

String _$todoListHash() => r'8a43dbb288eeeb4e0b008b5991ba12254e1e21c5';

abstract class _$TodoList extends $AsyncNotifier<List<Todo>> {
  FutureOr<List<Todo>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<List<Todo>>, List<Todo>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Todo>>, List<Todo>>,
              AsyncValue<List<Todo>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(CurrentFilter)
const currentFilterProvider = CurrentFilterProvider._();

final class CurrentFilterProvider
    extends $NotifierProvider<CurrentFilter, TodoFilter> {
  const CurrentFilterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentFilterProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentFilterHash();

  @$internal
  @override
  CurrentFilter create() => CurrentFilter();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TodoFilter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TodoFilter>(value),
    );
  }
}

String _$currentFilterHash() => r'ec3c87e89dea659d942fa6dfed05cee97243eb2a';

abstract class _$CurrentFilter extends $Notifier<TodoFilter> {
  TodoFilter build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<TodoFilter, TodoFilter>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<TodoFilter, TodoFilter>,
              TodoFilter,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(todoStats)
const todoStatsProvider = TodoStatsProvider._();

final class TodoStatsProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<String, int>>,
          Map<String, int>,
          FutureOr<Map<String, int>>
        >
    with $FutureModifier<Map<String, int>>, $FutureProvider<Map<String, int>> {
  const TodoStatsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'todoStatsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$todoStatsHash();

  @$internal
  @override
  $FutureProviderElement<Map<String, int>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Map<String, int>> create(Ref ref) {
    return todoStats(ref);
  }
}

String _$todoStatsHash() => r'79b1f203b47dc1e3fef5fdb1402fadd6db3142fa';

@ProviderFor(filteredTodoList)
const filteredTodoListProvider = FilteredTodoListProvider._();

final class FilteredTodoListProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Todo>>,
          List<Todo>,
          FutureOr<List<Todo>>
        >
    with $FutureModifier<List<Todo>>, $FutureProvider<List<Todo>> {
  const FilteredTodoListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'filteredTodoListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$filteredTodoListHash();

  @$internal
  @override
  $FutureProviderElement<List<Todo>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Todo>> create(Ref ref) {
    return filteredTodoList(ref);
  }
}

String _$filteredTodoListHash() => r'f4d9ab1853161f74075386914e63480bc893b2ba';

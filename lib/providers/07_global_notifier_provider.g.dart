// GENERATED CODE - DO NOT MODIFY BY HAND

part of '07_global_notifier_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(NotificationQueue)
const notificationQueueProvider = NotificationQueueProvider._();

final class NotificationQueueProvider
    extends $NotifierProvider<NotificationQueue, List<AppNotification>> {
  const NotificationQueueProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationQueueProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationQueueHash();

  @$internal
  @override
  NotificationQueue create() => NotificationQueue();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<AppNotification> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<AppNotification>>(value),
    );
  }
}

String _$notificationQueueHash() => r'2c2ec5be3dd88172d8d7e7993d92942e163ce69f';

abstract class _$NotificationQueue extends $Notifier<List<AppNotification>> {
  List<AppNotification> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<List<AppNotification>, List<AppNotification>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<AppNotification>, List<AppNotification>>,
              List<AppNotification>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

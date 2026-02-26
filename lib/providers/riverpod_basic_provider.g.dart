// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'riverpod_basic_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(riverpodBasicPageTemplate)
const riverpodBasicPageTemplateProvider = RiverpodBasicPageTemplateProvider._();

final class RiverpodBasicPageTemplateProvider
    extends $FunctionalProvider<String, String, String>
    with $Provider<String> {
  const RiverpodBasicPageTemplateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'riverpodBasicPageTemplateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$riverpodBasicPageTemplateHash();

  @$internal
  @override
  $ProviderElement<String> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String create(Ref ref) {
    return riverpodBasicPageTemplate(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$riverpodBasicPageTemplateHash() =>
    r'83a31cfeea34acd4f199ad570e5953387f0e63ce';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application/providers/riverpod_basic_provider.dart';

@RoutePage()
class RiverpodBasicPage extends ConsumerStatefulWidget {
  const RiverpodBasicPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RiverpodBasicPageState();
}

class _RiverpodBasicPageState extends ConsumerState<RiverpodBasicPage> {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(ref.read(riverpodBasicPageTemplateProvider)),
    );
  }
}
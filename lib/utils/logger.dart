import 'package:logging/logging.dart';
// 新增: 引入 riverpod 以继承 ProviderObserver
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 初始化日志配置
void _initLogger() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    // 简单优化：加上emoji区分级别
    final emoji = _getLevelEmoji(record.level);
    print('$emoji ${record.time}: [${record.loggerName}] ${record.message}');
  });
}

// 辅助函数：给日志级别加点表情，类似 Vue 报错时的红色/黄色
String _getLevelEmoji(Level level) {
  if (level == Level.SHOUT || level == Level.SEVERE) return '⛔';
  if (level == Level.WARNING) return '⚠️';
  if (level == Level.INFO) return 'ℹ️';
  if (level == Level.CONFIG) return '🔧';
  return '📝';
}

// 创建并初始化全局Logger实例
final Logger logger = (() {
  _initLogger();
  return Logger('App');
})();

// 为不同模块提供特定的logger创建函数
Logger getLogger(String name) {
  return Logger(name);
}

// ==========================================
// ⭐ 新增: Riverpod 监听器 (类似 Pinia Plugin)
//    适配 Riverpod 3.0 的 Observer
// ==========================================
base class RiverpodLogObserver extends ProviderObserver {
  final Logger _log = getLogger('Riverpod');

  @override
  void didUpdateProvider(
    ProviderObserverContext context, // 👈 3.0 变动：参数合并为 context
    Object? previousValue,
    Object? newValue,
  ) {
    // 从 context 中获取 provider
    final provider = context.provider;
    final providerName = provider.name ?? provider.runtimeType;

    // 过滤不需要的 provider
    // if (providerName == '') {
    //   return;
    // }

    _log.info('''
State Updated: $providerName
  👻 Prev: $previousValue
  ✨ Next: $newValue
''');
  }

  @override
  void didAddProvider(
    ProviderObserverContext context, // 👈 3.0 变动
    Object? value,
  ) {
    final provider = context.provider;
    final providerName = provider.name ?? provider.runtimeType;
    _log.fine('Provider Init: $providerName | Value: $value');
  }

  @override
  void didDisposeProvider(
    ProviderObserverContext context, // 👈 3.0 变动
  ) {
    final provider = context.provider;
    final providerName = provider.name ?? provider.runtimeType;
    _log.fine('Provider Disposed: $providerName 🗑️');
  }
}

/* 
  // 直接使用全局logger实例
  logger.info('这是一条信息日志');
  logger.warning('这是一条警告日志');
  logger.severe('这是一条错误日志');
  
  // 也可以使用getLogger函数创建特定模块的logger
  final moduleLogger = getLogger('myModule');
  moduleLogger.info('这是模块特定的日志');
  
  // 演示不同日志级别的使用
  logger.config('配置信息');
  logger.fine('详细信息');
  logger.finer('更详细的信息');
  logger.finest('最详细的信息');
 */
import 'dart:async';

import 'package:logging/logging.dart';
import 'package:injector/injector.dart';
import 'package:package_info/package_info.dart';

import 'ui/ui.dart';
import 'config.dart';

class PdContainer {
  static PdContainer _instance;

  final _injector = Injector();
  PdConfig _config;
  Future<void> onReady;

  factory PdContainer([PdConfig config]) {
    if (_instance == null) {
      _instance = PdContainer._(config);
    }

    return _instance;
  }

  PdContainer._(PdConfig config) {
    _config = config;

    onReady = Future(() async {

      registerLoggers();

      registerTheme();

    });
  }

  PdConfig get config {
    return _config;
  }

  void registerLoggers() {
    Logger.root.level = config.loggerLevel;
    Logger.root.onRecord.listen((record) {
      final label = record.loggerName.padRight(3).substring(0, 3).toUpperCase();
      final time = record.time.toIso8601String().substring(0, 23);
      final level = record.level.toString().padRight(4);
      print('$label $time $level ${record.message}');
    });

    _injector.registerSingleton<Logger>((injector) {
      return Logger('app');
    }, dependencyName: 'app');
    _injector.registerSingleton<Logger>((injector) {
      return Logger('action');
    }, dependencyName: 'action');
    _injector.registerSingleton<Logger>((injector) {
      return Logger('api');
    }, dependencyName: 'api');
  }

  Logger get appLogger {
    return _injector.getDependency<Logger>(dependencyName: 'app');
  }

  Logger get apiLogger {
    return _injector.getDependency<Logger>(dependencyName: 'api');
  }

  Logger get actionLogger {
    return _injector.getDependency<Logger>(dependencyName: 'action');
  }

  void registerTheme() {
    _injector.registerSingleton<PdTheme>((injector) {
      return PdTheme();
    });
  }

  PdTheme get theme {
    return _injector.getDependency<PdTheme>();
  }

}
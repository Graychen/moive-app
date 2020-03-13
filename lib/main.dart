import 'package:flutter/material.dart';

import 'ui/ui.dart';
import 'config.dart';
import 'container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final container = PdContainer(PdConfig());
  await container.onReady;
   runApp(PdApp(
    config: container.config,
    packageInfo: container.config.packageInfo,
    theme: container.theme.themeData,
));
}
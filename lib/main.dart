import 'package:fluent_ui/fluent_ui.dart';
import 'package:cloud_storage_drive_flutter/router/router.dart';
import 'package:cloud_storage_drive_flutter/services/tray.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await windowManager.ensureInitialized();

  WindowOptions windowOptions = WindowOptions(
    size: Size(1000, 600),
    center: false,
    // backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    // 同步原生窗口标题（任务栏悬停、Alt+Tab、任务管理器都会读它）
    await windowManager.setTitle('Flutter 网盘');
    await windowManager.setResizable(true);
    await windowManager.show();
    await windowManager.focus();
  });

  await initSystemTray();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FluentApp.router(
      title: 'Flutter 网盘',
      debugShowCheckedModeBanner: false,
      theme: FluentThemeData(accentColor: Colors.blue),
      routerConfig: router,
    );
  }
}

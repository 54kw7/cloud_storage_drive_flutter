import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:tray_manager/tray_manager.dart';
import 'package:window_manager/window_manager.dart';

// 必须持有这些引用。
// TrayIcon / Image 都是 ffi.Finalizable：Dart 对象一旦被 GC，
// 原生句柄就会被释放，托盘图标会直接消失（看起来就是「点了没反应」）。
// 它们只被赋值、不被读取，所以对分析器来说是 unused_element。
TrayIcon? _trayIcon;
// ignore: unused_element
Image? _trayIconImage;
// ignore: unused_element
Menu? _menu;

Future<void> initSystemTray() async {
  final iconPath = Platform.isWindows
      ? 'assets/images/tray.ico'
      : 'assets/images/tray.png';

  final iconImage = ImageAsset.fromAsset(iconPath);
  if (iconImage == null) {
    debugPrint('托盘图标加载失败：$iconPath（检查 pubspec 的 assets 配置）');
    return;
  }

  final trayIcon = TrayIcon.create()!;
  _trayIcon = trayIcon;
  _trayIconImage = iconImage;

  trayIcon.icon = iconImage;
  trayIcon.setTooltip('Flutter 网盘');

  // 左键单击 / 双击：显示主窗口（原生 API 不会自动帮你处理左键）
  trayIcon.addListener((event) {
    switch (event) {
      case TrayIconClickedEvent():
      case TrayIconDoubleClickedEvent():
        _showMainWindow();
      case TrayIconRightClickedEvent():
        // 右键菜单由下面的 setContextMenuTrigger 自动弹出；
        // 如果不用 trigger，也可以在这里手动 trayIcon.openContextMenu()。
        break;
    }
  });

  // 明确指定「右键弹出菜单」。
  // 不设置时默认触发方式取决于原生默认值，显式设置最稳妥。
  trayIcon.setContextMenuTrigger(ContextMenuTrigger.rightClicked);

  final menu = Menu.create()!;
  _menu = menu;

  final showWindowItem = MenuItem.createWithLabelAndType(
    '显示主窗口',
    MenuItemType.normal,
  )!;
  showWindowItem.addListener((event) {
    if (event is MenuItemClickedEvent) {
      _showMainWindow();
    }
  });
  menu.addItem(showWindowItem);

  menu.addSeparator();

  final exitItem = MenuItem.createWithLabelAndType('退出', MenuItemType.normal)!;
  exitItem.addListener((event) async {
    if (event is MenuItemClickedEvent) {
      await windowManager.destroy();
    }
  });
  menu.addItem(exitItem);

  trayIcon.setContextMenu(menu);
  trayIcon.setVisible(true);
}

/// 把主窗口叫回前台（最小化 / 隐藏状态下都能用）
void _showMainWindow() {
  windowManager.show();
  windowManager.focus();
}

/// 退出前销毁托盘图标，避免任务栏里残留「幽灵图标」
Future<void> destroySystemTray() async {
  _trayIcon?.setVisible(false);
  _trayIcon?.dispose();
  _trayIcon = null;
  _menu = null;
  _trayIconImage = null;
}

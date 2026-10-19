// 基础冒烟测试：确认 FluentApp 下页面能正常构建。
//
// 这里刻意不 pump 整个 MyApp：
// MyApp 使用 go_router + window_manager/tray_manager，
// 在纯 widget 测试环境里没有对应的原生插件实现，容易误报失败。

import 'package:cloud_storage_drive_flutter/pages/home.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('HomePage 能正常渲染', (WidgetTester tester) async {
    await tester.pumpWidget(const FluentApp(home: HomePage()));

    // PageHeader 和页面正文各有一个 "HomePage"
    expect(find.text('HomePage'), findsWidgets);
  });
}

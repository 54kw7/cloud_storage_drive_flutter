import 'package:fluent_ui/fluent_ui.dart';

class SubscribePage extends StatefulWidget {
  // 原来的 `const new({super.key});` 写法有误，改成正常的命名构造
  const SubscribePage({super.key});

  @override
  State<SubscribePage> createState() => _SubscribePageState();
}

class _SubscribePageState extends State<SubscribePage> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: const PageHeader(title: Text('SubscribePage')),
      content: const Center(child: Text('SubscribePage')),
    );
  }
}

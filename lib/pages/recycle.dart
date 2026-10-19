import 'package:fluent_ui/fluent_ui.dart';

class RecyclePage extends StatefulWidget {
  // 原来的 `const new({super.key});` 写法有误，改成正常的命名构造
  const RecyclePage({super.key});

  @override
  State<RecyclePage> createState() => _RecyclePageState();
}

class _RecyclePageState extends State<RecyclePage> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: const PageHeader(title: Text('RecyclePage')),
      content: const Center(child: Text('RecyclePage')),
    );
  }
}

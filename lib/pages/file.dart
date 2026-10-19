import 'package:fluent_ui/fluent_ui.dart';

class FilePage extends StatefulWidget {
  // 原来的 `const new({super.key});` 写法有误，改成正常的命名构造
  const FilePage({super.key});

  @override
  State<FilePage> createState() => _FilePageState();
}

class _FilePageState extends State<FilePage> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: const PageHeader(title: Text('FilePage')),
      content: const Center(child: Text('FilePage')),
    );
  }
}

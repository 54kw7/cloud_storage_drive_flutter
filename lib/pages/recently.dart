import 'package:fluent_ui/fluent_ui.dart';

class RecentlyPage extends StatefulWidget {
  // 原来的 `const new({super.key});` 写法有误，改成正常的命名构造
  const RecentlyPage({super.key});

  @override
  State<RecentlyPage> createState() => _RecentlyPageState();
}

class _RecentlyPageState extends State<RecentlyPage> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: const PageHeader(title: Text('RecentlyPage')),
      content: const Center(child: Text('RecentlyPage')),
    );
  }
}

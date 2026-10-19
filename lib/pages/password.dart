import 'package:fluent_ui/fluent_ui.dart';

class PasswordPage extends StatefulWidget {
  // 原来的 `const new({super.key});` 写法有误，改成正常的命名构造
  const PasswordPage({super.key});

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: const PageHeader(title: Text('PasswordPage')),
      content: const Center(child: Text('PasswordPage')),
    );
  }
}

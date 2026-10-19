import 'package:fluent_ui/fluent_ui.dart';

class UserPage extends StatefulWidget {
  // 字段必须 final，否则 must_be_immutable 报错
  final String? uid;
  const UserPage({super.key, this.uid});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  void initState() {
    super.initState();
    debugPrint('参数：${widget.uid}');
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: const PageHeader(title: Text('UserPage')),
      content: Center(child: Text('UserPage uid=${widget.uid}')),
    );
  }
}

import 'package:fluent_ui/fluent_ui.dart';

class PhotoPage extends StatefulWidget {
  // 原来的 `const new({super.key});` 写法有误，改成正常的命名构造
  const PhotoPage({super.key});

  @override
  State<PhotoPage> createState() => _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: const PageHeader(title: Text('PhotoPage')),
      content: const Center(child: Text('PhotoPage')),
    );
  }
}

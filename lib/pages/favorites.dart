import 'package:fluent_ui/fluent_ui.dart';

class FavoritesPage extends StatefulWidget {
  // 原来的 `const new({super.key});` 写法有误，改成正常的命名构造
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: const PageHeader(title: Text('FavoritesPage')),
      content: const Center(child: Text('FavoritesPage')),
    );
  }
}

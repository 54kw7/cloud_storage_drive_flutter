import 'package:fluent_ui/fluent_ui.dart';

class DocumentPage extends StatefulWidget {
  final String? aid;
  const DocumentPage({super.key, required this.aid});

  @override
  State<DocumentPage> createState() => _DocumentPageState();
}

class _DocumentPageState extends State<DocumentPage> {
  @override
  void initState() {
    super.initState();
    debugPrint(widget.aid);
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: const PageHeader(title: Text('DocumentPage')),
      content: Center(child: Text('DocumentPage aid=${widget.aid}')),
    );
  }
}

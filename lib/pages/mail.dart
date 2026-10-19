import 'package:fluent_ui/fluent_ui.dart';

class MailPage extends StatefulWidget {
  const MailPage({super.key});

  @override
  State<MailPage> createState() => _MailPageState();
}

class _MailPageState extends State<MailPage> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: const PageHeader(title: Text('MailPage')),
      content: const Center(child: Text('MailPage')),
    );
  }
}

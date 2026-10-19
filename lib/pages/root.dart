import "package:fluent_ui/fluent_ui.dart";
import "package:go_router/go_router.dart";
import "package:window_manager/window_manager.dart";

class RootPage extends StatefulWidget {
  // StatefulWidget / StatelessWidget 都是 @immutable，字段必须 final
  final Widget child;
  const RootPage({super.key, required this.child});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  // 用来让双击标题栏复用「最大化/还原」逻辑，状态保存在小部件内部，避免整页重建
  final _windowControlsKey = GlobalKey<_WindowControlsState>();

  /// 根据当前路由地址决定左侧哪一项高亮
  int _selectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    if (location.startsWith('/document')) return 1;
    if (location.startsWith('/user')) return 2;
    if (location.startsWith('/setting')) return 6;
    if (location.startsWith('/order')) return 5;
    if (location.startsWith('/mail')) return 3;
    if (location.startsWith('/calendar')) return 4;
    return 0;
  }

  /// 点击导航项后跳转
  void _onItemPressed(BuildContext context, int index) {
    switch (index) {
      case 1:
        context.go('/document?aid=10086');
      case 2:
        context.goNamed('user', pathParameters: {'uid': '1001'});
      case 6:
        context.goNamed('setting');
      case 5:
        context.goNamed('order');
      case 3:
        context.goNamed('mail');
      case 4:
        context.goNamed('calendar');
      default:
        context.go('/');
    }
  }

  /// 标题栏里显示的 logo。
  ///
  /// 注意：这里必须用 png。
  /// Flutter 的图片解码器支持 jpg/png/gif/webp/bmp，但不支持 .ico，
  /// Image.asset('xxx.ico') 会抛 "Could not instantiate image codec"。
  /// .ico 只留给托盘和原生窗口图标用。
  static const String _logoPath = 'assets/images/tray.png';

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      titleBar: TitleBar(
        icon: Image.asset(
          _logoPath,
          width: 16,
          height: 16,
          filterQuality: FilterQuality.high,
        ),
        title: const Text('Flutter 网盘'),
        // subtitle: const Text('Preview'),
        height: 40,
        captionControls: _WindowControls(key: _windowControlsKey),
        // 拖动窗口：TitleBar 内部自己有一个 GestureDetector，
        // 所以这里必须用它的回调，外层再包 DragToMoveArea 抢不到手势
        onDragStarted: () => windowManager.startDragging(),
        // 双击标题栏最大化 / 还原（复用按钮的逻辑与状态）
        onDoubleTap: () => _windowControlsKey.currentState?.toggleMaximize(),
      ),
      pane: NavigationPane(
        selected: _selectedIndex(context),
        onChanged: (index) => _onItemPressed(context, index),
        displayMode: PaneDisplayMode.auto,
        items: [
          PaneItem(
            icon: const Icon(FluentIcons.home),
            title: const Text('首页'),
            body: SizedBox.shrink(),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.document),
            title: const Text('文档'),
            body: SizedBox.shrink(),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.contact),
            title: const Text('用户'),
            body: SizedBox.shrink(),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.mail),
            title: const Text('邮箱'),
            body: SizedBox.shrink(),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.calendar),
            title: const Text('日历'),
            body: SizedBox.shrink(),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.activate_orders),
            title: const Text('订单'),
            body: SizedBox.shrink(),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.settings),
            title: const Text('设置'),
            body: SizedBox.shrink(),
          ),
        ],
      ),
      // 用 go_router 的 child 作为 pane 主体，而不是 PaneItem.body
      paneBodyBuilder: (item, body) => widget.child,
    );
  }
}

/// 窗口右上角的三个按钮。
///
/// 单独抽成一个 StatefulWidget 的原因：
/// 1. 最大化状态只影响这三个按钮，不必让整个 NavigationView 重建（重建大组件树会卡顿）；
/// 2. 通过 WindowListener 监听系统事件，图标在窗口变化的同一帧就能切换。
class _WindowControls extends StatefulWidget {
  const _WindowControls({super.key});

  @override
  State<_WindowControls> createState() => _WindowControlsState();
}

class _WindowControlsState extends State<_WindowControls> with WindowListener {
  bool _isMaximized = false;

  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
    _syncMaximized();
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  /// 首次进入时同步一次真实状态（比如窗口启动时就是最大化的）
  Future<void> _syncMaximized() async {
    final isMaximized = await windowManager.isMaximized();
    if (!mounted || isMaximized == _isMaximized) return;
    setState(() => _isMaximized = isMaximized);
  }

  @override
  void onWindowMaximize() {
    if (mounted && !_isMaximized) setState(() => _isMaximized = true);
  }

  @override
  void onWindowUnmaximize() {
    if (mounted && _isMaximized) setState(() => _isMaximized = false);
  }

  /// 最大化 / 还原。
  ///
  /// 直接用本地状态判断，不再 await isMaximized()，
  /// 少一次平台通道往返，点下去就是即时反馈。
  Future<void> toggleMaximize() async {
    if (_isMaximized) {
      await windowManager.unmaximize();
    } else {
      await windowManager.maximize();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        WindowCaptionButton.minimize(onPressed: () => windowManager.minimize()),
        // 关键是这一个：根据状态切换「最大化 / 还原」图标
        if (_isMaximized)
          WindowCaptionButton.unmaximize(onPressed: toggleMaximize)
        else
          WindowCaptionButton.maximize(onPressed: toggleMaximize),
        WindowCaptionButton.close(onPressed: () => windowManager.close()),
      ],
    );
  }
}

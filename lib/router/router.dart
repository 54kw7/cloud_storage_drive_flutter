import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:net_disk_flutter/pages/calendar.dart';
import 'package:net_disk_flutter/pages/document.dart';
import 'package:net_disk_flutter/pages/home.dart';
import 'package:net_disk_flutter/pages/mail.dart';
import 'package:net_disk_flutter/pages/order.dart';
import 'package:net_disk_flutter/pages/root.dart';
import 'package:net_disk_flutter/pages/setting.dart';
import 'package:net_disk_flutter/pages/user.dart';

final router = GoRouter(
  initialLocation: '/', // 初始化地址
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return RootPage(child: child);
      },
      routes: <RouteBase>[
        GoRoute(
          path: '/',
          name: 'home',
          builder: (context, state) => HomePage(),
        ),
        GoRoute(
          path: '/user/:uid',
          name: 'user',
          // 有 pageBuilder 时不能再写 builder，二者只能取其一
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              // key 必传，保证同一个路由的页面状态复用正确
              key: state.pageKey,
              child: UserPage(uid: state.pathParameters['uid']),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: CurveTween(curve: Curves.easeInOutCirc)
                          .animate(animation),
                      child: child,
                    );
                  },
            );
          },
        ),
        GoRoute(
          path: '/document',
          name: 'document',
          builder: (context, state) =>
              DocumentPage(aid: state.uri.queryParameters['aid']),
        ),
        GoRoute(
          path: '/setting',
          name: 'setting',
          builder: (context, state) => SettingPage(),
        ),
        GoRoute(
          path: '/order',
          name: 'order',
          builder: (context, state) => OrderPage(),
        ),
        GoRoute(
          path: '/mail',
          name: 'mail',
          builder: (context, state) => MailPage(),
        ),
        GoRoute(
          path: '/calendar',
          name: 'calendar',
          builder: (context, state) => CalendarPage(),
        ),
      ],
    ),
  ],
);

import 'package:flutter/material.dart';

import '../../ui.dart';

class PdTabBar extends StatelessWidget {
  static final tabs = [
    {
      'title': Text('首页'),
      'icon': Icon(Icons.home),
      //'builder': (BuildContext context) => HomePage(),
      //'refresh': HomePage.refresh,
    },
    {
      'title': Text('评论'),
      'icon': Icon(Icons.message),
      //'builder': (BuildContext context) => PublishPage(),
    },
    {
      'title': Text('个人'),
      'icon': Icon(Icons.account_circle),
      //'builder': (BuildContext context) => MePage(),
    },
  ];

  final int currentIndex;

  PdTabBar({
    this.currentIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (tab){
        SwitchTabNotification(tab).dispatch(context);

        final refresh = tabs[tab]['refresh'] as void Function();
        if (refresh != null && tab == this.currentIndex) refresh();
      },
      items: tabs
          .map(
            (v) => BottomNavigationBarItem(
              icon: v['icon'],
              title: v['title'],
            ),
          )
          .toList(),
    );
  }
}

class SwitchTabNotification extends Notification {
  final int tab;

  SwitchTabNotification(this.tab);
}
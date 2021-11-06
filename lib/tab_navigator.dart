import 'package:flutter/material.dart';

import 'Partner/page/PartnerListPage.dart';
import 'User/page/JoinPage.dart';
import 'Worklog/page/ScheduleListPage.dart';

class TabNavigatorRoutes {
  static const String root = '/';
  static const String detail = '/detail';
}

class TabNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState>? navigatorKey;
  final String tabItem;

  TabNavigator({required this.navigatorKey, required this.tabItem});


  @override
  Widget build(BuildContext context) {

    Widget child = JoinPage();

    if(tabItem == "JoinPage")
      child = JoinPage();
    else if(tabItem == "ScheduleListPage")
      child = ScheduleListPage();
    else if(tabItem == "PartnerListPage")
      child = PartnerListPage();

    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
            builder: (context) => child,

        );
      },
    );
  }
}
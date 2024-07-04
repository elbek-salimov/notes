import 'package:flutter/material.dart';

import 'add_note/add_note_screen.dart';
import 'home/home_screen.dart';
import 'pin/enter_pin_screen.dart';
import 'pin/set_pin_screen.dart';
import 'search/search_screen.dart';
import 'splash/splash_screen.dart';
import 'update_note/update_note_screen.dart';
import 'watch/watch_note_screen.dart';

class AppRoutes {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splashScreen:
        return navigate(const SplashScreen());

      case RouteNames.homeRoute:
        return navigate(const HomeScreen());

      case RouteNames.addNoteRoute:
        return navigate(const AddNoteScreen());

      case RouteNames.updateNoteRoute:
        Map<String, dynamic> map = settings.arguments as Map<String, dynamic>;
        return navigate(UpdateNoteScreen(
          id: map['id'] as int,
          title: map['title'] as String,
          text: map['text'] as String,
        ));

      case RouteNames.searchNoteRoute:
        return navigate(const SearchScreen());

      case RouteNames.watchNoteRoute:
        Map<String, dynamic> map = settings.arguments as Map<String, dynamic>;
        return navigate(WatchNoteScreen(
          id: map['id'] as int,
          title: map['title'] as String,
          text: map['text'] as String,
        ));

      case RouteNames.setPinRoute:
        return navigate(const SetPinScreen());

      case RouteNames.enterPinRoute:
        return navigate(const EnterPinScreen());

      default:
        return navigate(
          const Scaffold(
            body: Center(
              child: Text("This kind of rout does not exist!"),
            ),
          ),
        );
    }
  }

  static navigate(Widget widget) {
    return MaterialPageRoute(builder: (context) => widget);
  }
}

class RouteNames {
  static const String splashScreen = "/";
  static const String homeRoute = "/home_route";
  static const String addNoteRoute = "/add_note_route";
  static const String watchNoteRoute = "/watch_note_route";
  static const String updateNoteRoute = "/update_note_route";
  static const String searchNoteRoute = "/search_note_route";
  static const String setPinRoute = "/set_pin_route";
  static const String enterPinRoute = "/enter_pin_route";
}

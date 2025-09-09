import 'package:flutter/material.dart';
import 'package:mytodo/presentation/calendar/calendar_view.dart';
import 'package:mytodo/presentation/home/home_view.dart';
import 'package:mytodo/presentation/profile/profile_view.dart' show ProfileView;
import 'package:mytodo/presentation/task/task_view.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:stacked/stacked.dart';

class BottomNavigationViewmodel extends BaseViewModel {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  set setCurrentIndex(int value) {
    _currentIndex = value;
  }

  PersistentTabController controller = PersistentTabController(initialIndex: 0);

  final List<Widget> _children = [
    HomeView(),
    TaskView(),
    CalendarView(),
    ProfileView(),
  ];
  List<Widget> get children => _children;

  updateIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  resetValues() {
    _currentIndex = 0;
  }
}

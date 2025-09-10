import 'package:flutter/material.dart';
import 'package:mytodo/core/constants/colors.dart';
import 'package:mytodo/core/di/di.dart';
import 'package:mytodo/presentation/bottom_navigation_view/bottom_navigation_viewmodel.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:stacked/stacked.dart';

class BottomNavigationView extends StatelessWidget {
  const BottomNavigationView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => BottomNavigationViewmodel(),
      builder: (context, model, child) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          body: SafeArea(
            bottom: false,
            top: true,
            child: PersistentTabView(
              context,
              controller: model.controller,
              screens: model.children,
              items: [
                PersistentBottomNavBarItem(
                  icon: Icon(
                    Icons.home,
                  ),
                  title: "Home",
                  activeColorPrimary: AppColors.primaryColor,
                  inactiveColorPrimary: Colors.grey,
                ),
                PersistentBottomNavBarItem(
                  icon: Icon(
                    Icons.task,
                  ),
                  title: "Tasks",
                  activeColorPrimary: AppColors.primaryColor,
                  inactiveColorPrimary: Colors.grey,
                ),
                PersistentBottomNavBarItem(
                  icon: Icon(
                    Icons.calendar_month,
                  ),
                  title: ("Calendar"),
                  activeColorPrimary: AppColors.primaryColor,
                  inactiveColorPrimary: Colors.grey,
                ),
                PersistentBottomNavBarItem(
                  icon: Icon(
                    Icons.person,
                  ),
                  title: ("Profile"),
                  activeColorPrimary: AppColors.primaryColor,
                  inactiveColorPrimary: Colors.grey,
                ),
              ],
              handleAndroidBackButtonPress: true,
              resizeToAvoidBottomInset: false,
              stateManagement: false,
              hideNavigationBarWhenKeyboardAppears: true,
              popBehaviorOnSelectedNavBarItemPress: PopBehavior.once,

              padding: const EdgeInsets.only(top: 8),

              onWillPop: (final context) async {
                await showDialog(
                  context:
                      context ?? navigationService.navigatorKey.currentContext!,
                  useSafeArea: true,
                  builder: (final context) => Container(
                    height: 50,
                    width: 50,
                    color: Colors.white,
                    child: ElevatedButton(
                      child: const Text("Close"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                );
                return false;
              },

              backgroundColor: Colors.white,
              isVisible: true,
              animationSettings: const NavBarAnimationSettings(
                navBarItemAnimation: ItemAnimationSettings(
                  // Navigation Bar's items animation properties.
                  duration: Duration(milliseconds: 10),
                  curve: Curves.ease,
                ),
                screenTransitionAnimation: ScreenTransitionAnimationSettings(
                  // Screen transition animation on change of selected tab.
                  animateTabTransition: true,
                  duration: Duration(milliseconds: 10),
                  screenTransitionAnimationType:
                      ScreenTransitionAnimationType.slide,
                ),
              ),
              confineToSafeArea: true,
              navBarHeight: kBottomNavigationBarHeight,
              navBarStyle: NavBarStyle
                  .style9, // Choose the nav bar style with this property
            ),
          ),
        );
      },
    );
  }
}

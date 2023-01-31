import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:file_templeate/screen/homePage/showServicePlanner.dart';
import 'package:file_templeate/screen/homePage/showPackagPlanner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'Favorite.dart';
import 'homepage.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  PageController controller = PageController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  final screens = [
  Favorite(),HomePageService(),HomePagePackage()


  ];

  final _pageController = PageController(initialPage: 2);
  int maxCount = 3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(screens.length, (index) => screens[index]),
      ),
      extendBody: true,
      bottomNavigationBar: (screens.length <= maxCount)
          ? AnimatedNotchBottomBar(
              pageController: _pageController,
              color: Colors.white,
              showLabel: true,
              notchColor: Color.fromARGB(197, 143, 34, 170),
              bottomBarItems: [
                const BottomBarItem(
                  inActiveItem: Icon(
                    Icons.favorite_border,
                    color: Color.fromARGB(255, 35, 49, 140),
                  ),
                  activeItem: Icon(
                    Icons.favorite,
                    color: Color.fromARGB(255, 244, 244, 245),
                  ),
                  itemLabel: 'المفضلة',
                ),

                ///svg example

                const BottomBarItem(
                  inActiveItem: Icon(
                    Icons.shop_2_outlined,
                    color: Color.fromARGB(255, 35, 49, 140),
                  ),
                  activeItem: Icon(
                    Icons.shop_2_outlined,
                    color: Colors.white,
                  ),
                  itemLabel: 'الخدمه',
                ),
                const BottomBarItem(
                  inActiveItem: Icon(
                    Icons.home,
                    color: Color.fromARGB(255, 35, 49, 140),
                  ),
                  activeItem: Icon(
                    Icons.home_filled,
                    color: Colors.white,
                  ),
                  itemLabel: ' الخدمات',
                ),
              ],
              onTap: (index) {
                /// control your animation using page controller
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 350),
                  curve: Curves.easeIn,
                );
              },
            )
          : null,
    );
  }
}
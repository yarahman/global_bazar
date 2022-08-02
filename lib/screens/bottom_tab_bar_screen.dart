//dart imports ------------>

import 'dart:io' show Platform;

//flutter default imports ----------->

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' as web;
import 'package:global_bazar/theme/style.dart';
import 'package:global_bazar/widgets/web/pages/w_home_page.dart';

//android imports------>

import '../widgets/android/pages/account_page.dart';
import '../widgets/android/pages/cart_page.dart';
import '../widgets/android/pages/home_page.dart';
import '../widgets/android/pages/messenger_page.dart';
import '../widgets/android/pages/true_view_page.dart';

//ios imports --------->

import '../widgets/ios/pages/i_account_page.dart';
import '../widgets/ios/pages/i_cart_page.dart';
import '../widgets/ios/pages/i_home_page.dart';
import '../widgets/ios/pages/i_messender_page.dart';
import '../widgets/ios/pages/i_true_view_page.dart';

//web imports ------------>

class BottomTabbarScreen extends StatefulWidget {
  static const routeName = 'bottomTabBarScreen';
  const BottomTabbarScreen({Key? key}) : super(key: key);

  @override
  State<BottomTabbarScreen> createState() => _BottomTabbarScreenState();
}

class _BottomTabbarScreenState extends State<BottomTabbarScreen> {
  int currentIndex = 0;

  List<Widget> androidScreens = [
    const HomePage(),
    const TrueViewPage(),
    const MessengerPage(),
    const CartPage(),
    const AccountPage(),
  ];

  List<Widget> iosScreens = [
    const IHomePage(),
    const ITrueViewPage(),
    const IMessengerPage(),
    const ICartPage(),
    const IAccountPage()
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color.fromARGB(
          0,
          255,
          255,
          255,
        ),
      ),
    );

//*=======================         start web design          =========================================

//!note : if you not add this web condition on 1st than its gonna throw an platform error
//* so make sure that
//? web condition must always on above
    if (web.kIsWeb) {
      return Scaffold(
        drawer: screenWidth < 1050
            ? Drawer(
                width: 350.0,
                child: Column(
                  children: [
                    Container(
                      height: 200,
                      width: double.infinity,
                      color: Colors.grey,
                      child: Image.asset(
                        'assets/images/bazar_web_logo.png',
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ListView(
                          children: [
                            ListTile(
                              leading: const Icon(
                                Icons.account_circle,
                                color: Style.defaultColor,
                                size: 45,
                              ),
                              title: const Text('Sign In \nJoin Free'),
                              onTap: () {},
                              trailing: const RotatedBox(
                                quarterTurns: 2,
                                child: Icon(
                                  Icons.arrow_back_ios_rounded,
                                  size: 15,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            if (screenWidth <= 600)
                              ListTile(
                                leading: const Text(
                                  'Categories',
                                  style: TextStyle(color: Style.defaultColor),
                                ),
                                onTap: () {},
                                trailing: const RotatedBox(
                                  quarterTurns: 2,
                                  child: Icon(Icons.arrow_back_ios_rounded,
                                      size: 15),
                                ),
                              ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            ListTile(
                              leading: const Text(
                                'Ready To Ship',
                                style: TextStyle(color: Style.defaultColor),
                              ),
                              onTap: () {},
                              trailing: const RotatedBox(
                                quarterTurns: 2,
                                child: Icon(Icons.arrow_back_ios_rounded,
                                    size: 15),
                              ),
                            ),
                            ListTile(
                              leading: const Text(
                                'Personal Protective Equipments',
                                style: TextStyle(color: Style.defaultColor),
                              ),
                              onTap: () {},
                              trailing: const RotatedBox(
                                quarterTurns: 2,
                                child: Icon(Icons.arrow_back_ios_rounded,
                                    size: 15),
                              ),
                            ),
                            ListTile(
                              leading: const Text(
                                'Trade Show',
                                style: TextStyle(color: Style.defaultColor),
                              ),
                              onTap: () {},
                              trailing: const RotatedBox(
                                quarterTurns: 2,
                                child: Icon(Icons.arrow_back_ios_rounded,
                                    size: 15),
                              ),
                            ),
                            ListTile(
                              leading: const Text(
                                'Buyer Central',
                                style: TextStyle(color: Style.defaultColor),
                              ),
                              onTap: () {},
                              trailing: const RotatedBox(
                                quarterTurns: 2,
                                child: Icon(Icons.arrow_back_ios_rounded,
                                    size: 15),
                              ),
                            ),
                            ListTile(
                              leading: const Text(
                                'Sell On Global',
                                style: TextStyle(color: Style.defaultColor),
                              ),
                              onTap: () {},
                              trailing: const RotatedBox(
                                quarterTurns: 2,
                                child: Icon(Icons.arrow_back_ios_rounded,
                                    size: 15),
                              ),
                            ),
                            ListTile(
                              leading: const Text(
                                'Help',
                                style: TextStyle(color: Style.defaultColor),
                              ),
                              onTap: () {},
                              trailing: const RotatedBox(
                                quarterTurns: 2,
                                child: Icon(Icons.arrow_back_ios_rounded,
                                    size: 15),
                              ),
                            ),
                            const SizedBox(
                              height: 25.0,
                            ),
                            ListTile(
                              leading: const Text(
                                'Get The App',
                                style: TextStyle(color: Style.defaultColor),
                              ),
                              onTap: () {},
                              trailing: const RotatedBox(
                                quarterTurns: 2,
                                child: Icon(Icons.arrow_back_ios_rounded,
                                    size: 15),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : null,
        body: const WHomePage(),
      );
    }

//?######################## end web design ##########################

//*=============================== start windows design =================================
    else if (Platform.isWindows) {
      return const Scaffold(
        body: Center(
          child: Text(
            'running on windows also',
          ),
        ),
      );
    }

//? ############################## end windows design ########################

//* ========================= start android design ================================
    else if (Platform.isAndroid) {
      return Scaffold(
        body: androidScreens[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: const Color.fromARGB(255, 114, 114, 114),
          selectedItemColor: Colors.deepOrange,
          currentIndex: currentIndex,
          selectedLabelStyle: const TextStyle(fontFamily: 'ARD'),
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              activeIcon: ImageIcon(
                AssetImage(
                  'assets/images/bazar_icon.png',
                ),
                size: 35,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage(
                  'assets/images/true_view.png',
                ),
                size: 28,
              ),
              label: 'True View',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage(
                  'assets/images/chat_icon.png',
                ),
                size: 25,
              ),
              label: 'Messager',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.shopify_outlined,
                size: 25,
              ),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage(
                  'assets/images/account_icon.png',
                ),
                size: 25,
              ),
              label: 'My Bazar',
            ),
          ],
        ),
      );
    }
//? #################### end android design #############################

    else if (Platform.isIOS) {
      return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          activeColor: Colors.deepOrange,
          inactiveColor: const Color.fromARGB(255, 114, 114, 114),
          currentIndex: currentIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              activeIcon: ImageIcon(
                AssetImage(
                  'assets/images/bazar_icon.png',
                ),
                size: 35,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage(
                  'assets/images/true_view.png',
                ),
                size: 28,
              ),
              label: 'True View',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage(
                  'assets/images/chat_icon.png',
                ),
                size: 25,
              ),
              label: 'Messager',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.shopify_outlined,
                size: 25,
              ),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage(
                  'assets/images/account_icon.png',
                ),
                size: 25,
              ),
              label: 'My Bazar',
            ),
          ],
        ),
        tabBuilder: (context, index) {
          return CupertinoTabView(
            builder: (context) {
              return iosScreens[index];
            },
          );
        },
      );
    } else {
      return Container();
    }
  }
}

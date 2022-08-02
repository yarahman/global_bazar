import 'package:flutter/material.dart';

import '../../../theme/style.dart';

class WHomePage extends StatefulWidget {
  const WHomePage();

  @override
  State<WHomePage> createState() => _WHomePageState();
}

class _WHomePageState extends State<WHomePage> with TickerProviderStateMixin {
  //* ################# global variables ############################
  var textFieldButtonColor = false;
  var searchButtonColor = false;
  var createAccountColor = false;
  var messgeButtonColor = false;
  var orderButtonColor = false;
  var cartButtonColor = false;
  var categoryButtonColor = false;
  var readyToShipButton = false;
  var personalProtectiveButtonColor = false;
  var tradeShowButtonColor = false;
  var buyerCentralColor = false;
  var sellOnGlobalButtonColor = false;
  var helpButtonColor = false;
  var getTheAppButtonColor = false;

  var mobileScreenSize = 500;
  var tabletScreenSize = 700;

  late AnimationController topDesignAnimController;
  late Animation<Size> topDesignAnimation;

  late AnimationController categoryButtonIconContoller;
  late Animation<double> categoryButtonAnimation;

  late AnimationController buyerCentralController;
  late Animation<double> buyerCentralAnimation;

  late AnimationController sellOnGlobalController;
  late Animation<double> sellOnGlobalAnimation;

  late AnimationController helpController;
  late Animation<double> helpAnimation;

  var animatedCatagoryIcon = const Icon(Icons.expand_less);
  var animatedBuyerCentralIcon = const Icon(Icons.expand_less);
  var animatedSellOnGlobalIcon = const Icon(Icons.expand_less);
  var animatedHelpIcon = const Icon(Icons.expand_less);

//flutter default methods --------------
  @override
  void initState() {
//*top design animation controller
    topDesignAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

//*category button animation controller
    categoryButtonIconContoller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 200,
      ),
    );

//*buyer central button animation controller
    buyerCentralController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 200,
      ),
    );

//*sell on global button animaiton controller
    sellOnGlobalController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 200,
      ),
    );

//*help button animation controller
    helpController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));

//top design animation
    topDesignAnimation = Tween<Size>(
            begin: const Size(0.0, double.infinity),
            end: const Size(200.0, double.infinity))
        .animate(CurvedAnimation(
            parent: topDesignAnimController, curve: Curves.linear));

//category button animaiton
    categoryButtonAnimation =
        Tween<double>(begin: 0.0, end: 90).animate(categoryButtonIconContoller);

//buyer central button animation
    buyerCentralAnimation =
        Tween<double>(begin: 0.0, end: 90).animate(buyerCentralController);

//sell on global button animation
    sellOnGlobalAnimation =
        Tween<double>(begin: 0.0, end: 90).animate(sellOnGlobalController);

//help button animation
    helpAnimation = Tween<double>(begin: 0.0, end: 90).animate(helpController);

    topDesignAnimation.addListener(() {
      setState(() {});
    });

    categoryButtonAnimation.addListener(() {
      setState(() {});
    });

    buyerCentralAnimation.addListener(() {
      setState(() {});
    });

    sellOnGlobalAnimation.addListener(() {
      setState(() {});
    });

    helpAnimation.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth > 1500) {
      topDesignAnimController.forward();
    } else if (screenWidth < 1300) {
      topDesignAnimController.reverse();
    }

//when user browse with mobile phone
//that time this design for mobile users
    if (screenWidth <= 600) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    30.0,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: TextButton.icon(
                    onPressed: () {
                      setState(() {
                        Scaffold.of(context).openDrawer();
                      });
                    },
                    icon: const Icon(
                      Icons.menu_rounded,
                    ),
                    label: const Text(
                      'Menu',
                      style: TextStyle(
                        color: Style.defaultColor,
                      ),
                    ),
                  ),
                ),
              ),
              globalBazarLogo(),
              Row(
                children: [
                  messageButton(),
                  const SizedBox(
                    width: 15.0,
                  ),
                  orderButton(),
                  const SizedBox(
                    width: 15.0,
                  ),
                  cartButton(),
                  const SizedBox(
                    width: 15.0,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 15.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
            ),
            child: Row(
              children: [
                searchTextField(),
                searchButton(),
              ],
            ),
          ),
        ],
      );
    }
//end of the mobile user design ---------!

//*if user browse with tablet devices
//* that time this design for tablet users
    else if (screenWidth < 1050) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    30.0,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: TextButton.icon(
                    onPressed: () {
                      setState(() {
                        Scaffold.of(context).openDrawer();
                      });
                    },
                    icon: const Icon(
                      Icons.menu_rounded,
                    ),
                    label: const Text(
                      'Menu',
                      style: TextStyle(
                        color: Style.defaultColor,
                      ),
                    ),
                  ),
                ),
              ),
              globalBazarLogo(),
              Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: categoryButton()),
            ],
          ),
          Row(
            children: [
              const SizedBox(
                width: 10.0,
              ),
              searchTextField(),
              searchButton(),
              const SizedBox(width: 10.0),
              messageButton(),
              const SizedBox(
                width: 20.0,
              ),
              orderButton(),
              const SizedBox(
                width: 20.0,
              ),
              cartButton(),
              const SizedBox(
                width: 20.0,
              ),
            ],
          ),
        ],
      );
    }
//* end of the tablet design----------------!

//for desktop user that design will shown
    else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
// #################################### top design ##########################################
          Padding(
            padding: screenWidth > 1300
                ? EdgeInsets.symmetric(
                    horizontal: topDesignAnimation.value.width)
                : EdgeInsets.symmetric(
                    horizontal: topDesignAnimation.value.width),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
//* global bazar logo image----------->
                globalBazarLogo(),
                const SizedBox(
                  width: 40.0,
                ),
//*searched text field and searched with image button ---------->
                searchTextField(),

//* searched button -------------->
                searchButton(),
                const SizedBox(
                  width: 10.0,
                ),

                Row(
                  children: [
//* sign in button ---------->
                    InkWell(
                      onTap: () {},
                      onHover: (value) {
                        setState(() {
                          createAccountColor = value;
                        });
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.account_circle_rounded,
                            color: createAccountColor
                                ? Style.defaultColor
                                : Colors.grey,
                            size: 40.0,
                          ),
                          const SizedBox(
                            width: 3.0,
                          ),
                          Text(
                            'Sign In \nJoin Free',
                            style: TextStyle(
                              color: createAccountColor
                                  ? Style.defaultColor
                                  : Style.isDark
                                      ? Colors.white
                                      : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 25.0,
                    ),

//* message button ----------------->
                    messageButton(),
                    const SizedBox(
                      width: 25.0,
                    ),

//*order button --------------->
                    orderButton(),
                    const SizedBox(
                      width: 25.0,
                    ),

//* cart button ----------------->
                    cartButton(),
                    const SizedBox(
                      width: 25.0,
                    ),
                  ],
                ),
              ],
            ),
          ),
//############################################ end top design ####################################################

          SizedBox(
            width: double.infinity,
            height: 50,
            child: Card(
              color: Style.isDark ? const Color(0xff303134) : Colors.white,
              elevation: 5.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      const SizedBox(
                        width: 10.0,
                      ),

//* category button ------------>
                      categoryButton(),
                      const SizedBox(
                        width: 20.0,
                      ),

//* divider after category button ------>
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Container(
                          height: double.infinity,
                          width: 0.2,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        width: 20.0,
                      ),

//* ready to ship button ---------->
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Ready To Ship',
                          style: TextStyle(
                              color: readyToShipButton
                                  ? Style.defaultColor
                                  : Style.isDark
                                      ? Colors.white
                                      : Colors.black),
                        ),
                        onHover: (value) {
                          setState(() {
                            readyToShipButton = value;
                          });
                        },
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),

//* personal protective equipmetn button -------->
                      TextButton(
                        onHover: (value) {
                          setState(() {
                            personalProtectiveButtonColor = value;
                          });
                        },
                        onPressed: () {},
                        child: Text(
                          'Personal Protective Equipments',
                          style: TextStyle(
                            color: personalProtectiveButtonColor
                                ? Style.defaultColor
                                : Style.isDark
                                    ? Colors.white
                                    : Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
//* start trade show button ---------->
                      TextButton(
                        onHover: (value) {
                          setState(() {
                            tradeShowButtonColor = value;
                          });
                        },
                        onPressed: () {},
                        child: Text(
                          'Trade Show',
                          style: TextStyle(
                            color: tradeShowButtonColor
                                ? Style.defaultColor
                                : Style.isDark
                                    ? Colors.white
                                    : Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),

//* buyer central button ----------->
                      InkWell(
                        onTap: () {
                          if (buyerCentralAnimation.status ==
                              AnimationStatus.completed) {
                            buyerCentralController.reverse();
                            setState(() {
                              animatedBuyerCentralIcon = Icon(
                                Icons.expand_less,
                                color: categoryButtonColor
                                    ? Style.defaultColor
                                    : Colors.white,
                              );
                            });
                          } else {
                            buyerCentralController.forward();
                            setState(
                              () {
                                animatedBuyerCentralIcon = Icon(
                                  Icons.expand_more,
                                  color: categoryButtonColor
                                      ? Style.defaultColor
                                      : Colors.white,
                                );
                              },
                            );
                          }
                        },
                        onHover: (value) {
                          setState(() {
                            buyerCentralColor = value;
                          });
                          if (buyerCentralColor) {
                            buyerCentralController.forward();
                            setState(() {
                              animatedBuyerCentralIcon = Icon(
                                Icons.expand_more,
                                color: buyerCentralColor
                                    ? Style.defaultColor
                                    : Style.isDark
                                        ? Colors.white
                                        : Colors.black,
                              );
                            });
                          } else {
                            buyerCentralController.reverse();
                            setState(() {
                              animatedBuyerCentralIcon = Icon(
                                Icons.expand_less,
                                color: categoryButtonColor
                                    ? Style.defaultColor
                                    : Style.isDark
                                        ? Colors.white
                                        : Colors.black,
                              );
                            });
                          }
                        },
                        overlayColor: MaterialStateProperty.all(
                          const Color.fromARGB(0, 255, 255, 255),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              'Buyer Central',
                              style: TextStyle(
                                  color: buyerCentralColor
                                      ? Style.defaultColor
                                      : Style.isDark
                                          ? Colors.white
                                          : Colors.black),
                            ),
                            const SizedBox(
                              width: 3.0,
                            ),
                            Transform.rotate(
                              angle: buyerCentralController.value * 6.3,
                              child: animatedBuyerCentralIcon,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),

//* sell on global button ---------->
                      InkWell(
                        onTap: () {
                          if (sellOnGlobalAnimation.status ==
                              AnimationStatus.completed) {
                            sellOnGlobalController.reverse();
                            setState(() {
                              animatedSellOnGlobalIcon = Icon(
                                Icons.expand_less,
                                color: sellOnGlobalButtonColor
                                    ? Style.defaultColor
                                    : Colors.white,
                              );
                            });
                          } else {
                            sellOnGlobalController.forward();
                            setState(
                              () {
                                animatedSellOnGlobalIcon = Icon(
                                  Icons.expand_more,
                                  color: sellOnGlobalButtonColor
                                      ? Style.defaultColor
                                      : Colors.white,
                                );
                              },
                            );
                          }
                        },
                        onHover: (value) {
                          setState(() {
                            sellOnGlobalButtonColor = value;
                          });
                          if (sellOnGlobalButtonColor) {
                            sellOnGlobalController.forward();
                            setState(() {
                              animatedSellOnGlobalIcon = Icon(
                                Icons.expand_more,
                                color: sellOnGlobalButtonColor
                                    ? Style.defaultColor
                                    : Style.isDark
                                        ? Colors.white
                                        : Colors.black,
                              );
                            });
                          } else {
                            sellOnGlobalController.reverse();
                            setState(() {
                              animatedSellOnGlobalIcon = Icon(
                                Icons.expand_less,
                                color: sellOnGlobalButtonColor
                                    ? Style.defaultColor
                                    : Style.isDark
                                        ? Colors.white
                                        : Colors.black,
                              );
                            });
                          }
                        },
                        overlayColor: MaterialStateProperty.all(
                          const Color.fromARGB(0, 255, 255, 255),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              'Sell On Global',
                              style: TextStyle(
                                  color: sellOnGlobalButtonColor
                                      ? Style.defaultColor
                                      : Style.isDark
                                          ? Colors.white
                                          : Colors.black),
                            ),
                            const SizedBox(
                              width: 3.0,
                            ),
                            Transform.rotate(
                              angle: sellOnGlobalController.value * 6.3,
                              child: animatedSellOnGlobalIcon,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),

//*  help button -------------->
                      InkWell(
                        onTap: () {
                          if (helpAnimation.status ==
                              AnimationStatus.completed) {
                            helpController.reverse();
                            setState(() {
                              animatedHelpIcon = Icon(
                                Icons.expand_less,
                                color: helpButtonColor
                                    ? Style.defaultColor
                                    : Colors.white,
                              );
                            });
                          } else {
                            helpController.forward();
                            setState(
                              () {
                                animatedHelpIcon = Icon(
                                  Icons.expand_more,
                                  color: helpButtonColor
                                      ? Style.defaultColor
                                      : Colors.white,
                                );
                              },
                            );
                          }
                        },
                        onHover: (value) {
                          setState(() {
                            helpButtonColor = value;
                          });
                          if (helpButtonColor) {
                            helpController.forward();
                            setState(() {
                              animatedHelpIcon = Icon(
                                Icons.expand_more,
                                color: helpButtonColor
                                    ? Style.defaultColor
                                    : Style.isDark
                                        ? Colors.white
                                        : Colors.black,
                              );
                            });
                          } else {
                            helpController.reverse();
                            setState(() {
                              animatedHelpIcon = Icon(
                                Icons.expand_less,
                                color: helpButtonColor
                                    ? Style.defaultColor
                                    : Style.isDark
                                        ? Colors.white
                                        : Colors.black,
                              );
                            });
                          }
                        },
                        overlayColor: MaterialStateProperty.all(
                          const Color.fromARGB(0, 255, 255, 255),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              'Help',
                              style: TextStyle(
                                  color: helpButtonColor
                                      ? Style.defaultColor
                                      : Style.isDark
                                          ? Colors.white
                                          : Colors.black),
                            ),
                            const SizedBox(
                              width: 3.0,
                            ),
                            Transform.rotate(
                              angle: helpController.value * 6.3,
                              child: animatedHelpIcon,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),

//* get the app button ----------->
                      TextButton(
                        onHover: (value) {
                          setState(() {
                            getTheAppButtonColor = value;
                          });
                        },
                        onPressed: () {},
                        child: Text(
                          'Get The App',
                          style: TextStyle(
                              color: getTheAppButtonColor
                                  ? Style.defaultColor
                                  : Style.isDark
                                      ? Colors.white
                                      : Colors.black),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      );
    }
// end of the desktop users
  }

//cart button method-----------------
  InkWell cartButton() {
    return InkWell(
      onTap: () {},
      onHover: (value) {
        setState(() {
          cartButtonColor = value;
        });
      },
      child: Column(
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            color: cartButtonColor ? Style.defaultColor : Colors.grey,
          ),
          Text(
            'Cart',
            style: TextStyle(
              color: cartButtonColor
                  ? Style.defaultColor
                  : Style.isDark
                      ? Colors.white
                      : Colors.black,
            ),
          )
        ],
      ),
    );
  }

// order button method----------------
  InkWell orderButton() {
    return InkWell(
      onTap: () {},
      onHover: (value) {
        setState(() {
          orderButtonColor = value;
        });
      },
      child: Column(
        children: [
          Icon(
            Icons.attach_money_sharp,
            color: orderButtonColor ? Style.defaultColor : Colors.grey,
          ),
          Text(
            'Order',
            style: TextStyle(
              color: orderButtonColor
                  ? Style.defaultColor
                  : Style.isDark
                      ? Colors.white
                      : Colors.black,
            ),
          )
        ],
      ),
    );
  }

//message button method---------------
  InkWell messageButton() {
    return InkWell(
      onTap: () {},
      onHover: (value) {
        setState(() {
          messgeButtonColor = value;
        });
      },
      child: Column(
        children: [
          Icon(
            Icons.chat_outlined,
            color: messgeButtonColor ? Style.defaultColor : Colors.grey,
          ),
          Text(
            'Message',
            style: TextStyle(
              color: messgeButtonColor
                  ? Style.defaultColor
                  : Style.isDark
                      ? Colors.white
                      : Colors.black,
            ),
          )
        ],
      ),
    );
  }

//category button method -------------------
  InkWell categoryButton() {
    return InkWell(
      onTap: () {
        if (categoryButtonAnimation.status == AnimationStatus.completed) {
          categoryButtonIconContoller.reverse();
          setState(() {
            animatedCatagoryIcon = Icon(
              Icons.expand_less,
              color: categoryButtonColor ? Style.defaultColor : Colors.white,
            );
          });
        } else {
          categoryButtonIconContoller.forward();
          setState(() {
            animatedCatagoryIcon = Icon(
              Icons.expand_more,
              color: categoryButtonColor ? Style.defaultColor : Colors.white,
            );
          });
        }
      },
      onHover: (value) {
        setState(() {
          categoryButtonColor = value;
        });
        if (categoryButtonColor) {
          categoryButtonIconContoller.forward();
          setState(() {
            animatedCatagoryIcon = Icon(
              Icons.expand_more,
              color: categoryButtonColor
                  ? Style.defaultColor
                  : Style.isDark
                      ? Colors.white
                      : Colors.black,
            );
          });
        } else {
          categoryButtonIconContoller.reverse();
          setState(() {
            animatedCatagoryIcon = Icon(
              Icons.expand_less,
              color: categoryButtonColor
                  ? Style.defaultColor
                  : Style.isDark
                      ? Colors.white
                      : Colors.black,
            );
          });
        }
      },
      overlayColor: MaterialStateProperty.all(
        const Color.fromARGB(0, 255, 255, 255),
      ),
      child: Row(
        children: [
          Icon(
            Icons.menu_sharp,
            color: categoryButtonColor
                ? Style.defaultColor
                : Style.isDark
                    ? Colors.white
                    : Colors.black,
          ),
          const SizedBox(
            width: 5.0,
          ),
          Text(
            'Categories',
            style: TextStyle(
                color: categoryButtonColor
                    ? Style.defaultColor
                    : Style.isDark
                        ? Colors.white
                        : Colors.black),
          ),
          const SizedBox(
            width: 3.0,
          ),
          Transform.rotate(
            angle: categoryButtonIconContoller.value * 6.3,
            child: animatedCatagoryIcon,
          ),
        ],
      ),
    );
  }

//searched button method --------------
  InkWell searchButton() {
    return InkWell(
      onTap: () {},
      onHover: (value) {
        setState(() {
          searchButtonColor = value;
        });
      },
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(40.0),
        bottomRight: Radius.circular(
          40.0,
        ),
      ),
      child: Container(
        height: 43,
        width: 120,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: searchButtonColor
              ? const Color.fromARGB(255, 218, 51, 0)
              : Style.defaultColor,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(40.0),
            bottomRight: Radius.circular(
              40.0,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.search,
              color: Colors.white54,
            ),
            SizedBox(
              width: 8.0,
            ),
            Text(
              'Search',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'CORBEL',
              ),
            ),
          ],
        ),
      ),
    );
  }

//searched textfield method ------------
  Flexible searchTextField() {
    return Flexible(
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          TextField(
            decoration: InputDecoration(
              isDense: true,
              hintText: 'what are your looking for',
              hintStyle: TextStyle(
                color: Colors.grey.withOpacity(
                  0.7,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  bottomLeft: Radius.circular(
                    40.0,
                  ),
                ),
                borderSide: BorderSide(
                  color: searchButtonColor
                      ? const Color.fromARGB(255, 218, 51, 0)
                      : Style.defaultColor,
                  width: 1.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  bottomLeft: Radius.circular(
                    40.0,
                  ),
                ),
                borderSide: BorderSide(
                  color: searchButtonColor
                      ? const Color.fromARGB(255, 218, 51, 0)
                      : Style.defaultColor,
                  width: 1.0,
                ),
              ),
              border: InputBorder.none,
            ),
          ),

//searched with image button method------------------
          InkWell(
            onTap: () {},
            onHover: (value) {
              setState(() {
                textFieldButtonColor = value;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: Icon(
                Icons.image_search_rounded,
                color: textFieldButtonColor ? Style.defaultColor : Colors.grey,
              ),
            ),
          )
        ],
      ),
    );
  }

// Global Bazar Logo
  SizedBox globalBazarLogo() {
    return SizedBox(
      height: 80,
      width: 150,
      child: InkWell(
        borderRadius: BorderRadius.circular(50.0),
        onTap: () {},
        child: Image.asset(
          'assets/images/bazar_web_logo.png',
        ),
      ),
    );
  }
}

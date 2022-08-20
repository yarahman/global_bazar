import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './theme/style.dart';
import './screens/bottom_tab_bar_screen.dart';
import './screens/android/product_detail_screen.dart';
import './screens/android/adding_product_screen.dart';
import './screens/android/image_preivew_screen.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
//----------------------default screen status bar color ----------------------------
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Style.isDark
                ? Color.fromARGB(
                    0,
                    255,
                    255,
                    255,
                  )
                : Color.fromARGB(
                    0,
                    255,
                    255,
                    255,
                  ),
          ),

//? ###################### end of the screen status bar color#######################

//---------- default elevation of every screen app bar -----------------
          elevation: 0.0,

//?###### end of elevation on app bar ###################

//------------ default app bar icon color ---------------------------------------
          iconTheme: IconThemeData(
            color: Style.isDark ? Colors.white : Colors.black,
          ),

//?######### end of app bar icon color #################

//--------- default app bar text style ------------------------------------
          titleTextStyle: TextStyle(
            color: Style.isDark ? Colors.white : Colors.black,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'ARD',
          ),

//?######### end app bar text style #########################

//-------------------- default app bar background color ----------------------
          backgroundColor: Style.isDark
              ? Color.fromARGB(
                  0,
                  45,
                  46,
                  48,
                )
              : Color.fromARGB(
                  0,
                  255,
                  255,
                  255,
                )
//?########### end app bar text style #################
          ,
        ),

//---------------- entire app default color ---------------------
        primarySwatch: Style.defaultColor,

//?########## end app default color ###############

//------------------------------ app light and dark mode -------------------------
        brightness: Style.isDark ? Brightness.dark : Brightness.light,
      ),

//?############### end app light and dark mode ################
      // home: const BottomTabbarScreen(),
      initialRoute: AddingProductScreen.routeName,
      routes: {
        BottomTabbarScreen.routeName: (context) => const BottomTabbarScreen(),
        ProductDetailScreen.routeName:(context) => const ProductDetailScreen(),
        AddingProductScreen.routeName :(context) => const AddingProductScreen(),
        ImagePreviewScreen.routeName :(context) => ImagePreviewScreen(),


      },
    );
  }
}

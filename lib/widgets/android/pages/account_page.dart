import 'package:flutter/material.dart';

import '../../../theme/style.dart';
import '../../../screens/android/adding_product_screen.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Icon(
                Icons.library_add_check_outlined,
                color: Style.defaultColor.withOpacity(0.5),
                size: 180,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            const Text(
              'please sign up/log in before start shopping',
              style: TextStyle(
                fontFamily: Style.corbel,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            signLogButton(
                borderColor: Style.defaultColor.withOpacity(
                  0.5,
                ),
                ontap: () {},
                text: 'Sign Up'),
            signLogButton(
              borderColor: Colors.grey,
              ontap: () {},
              text: 'Log In',
            ),
            const Divider(
              color: Colors.grey,
              height: 100,
              thickness: 0.1,
            ),
            const Text(
              'Explore ',
              style: TextStyle(
                fontFamily: Style.ard,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.all(
                2.0,
              ),
              child: GridView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  mainAxisExtent: 110,
                ),
                children: [
                  exploreGridItems(
                    text: 'Popular Products',
                    assetImage: 'assets/images/popular_prd.png',
                    onTap: () {},
                  ),
                  exploreGridItems(
                    text: 'True View',
                    assetImage: 'assets/images/true_view_prd.png',
                    onTap: () {},
                  ),
                  exploreGridItems(
                    text: 'Offers',
                    assetImage: 'assets/images/offers.png',
                    onTap: () {},
                  ),
                  exploreGridItems(
                    text: 'Ready to Ship\nProducts',
                    assetImage: 'assets/images/ships_prd.png',
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(
                5.0,
              ),
              child: bottomButtons(
                icon: Icons.add_shopping_cart_outlined,
                ontap: () {
                  Navigator.of(context).pushNamed(
                    AddingProductScreen.routeName,
                  );
                },
                text: 'Add Product',
              ),
            ),
          ],
        ),
      ),
    );
  }

//
//
//
//* --------------------------- All Widget Methods Start Form Here--->
//
//
//
//
//* bottom buttons --------------->
  Widget bottomButtons(
      {required IconData icon,
      required String text,
      required VoidCallback ontap}) {
    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          20.0,
        ),
      ),
      child: InkWell(
        onTap: ontap,
        borderRadius: BorderRadius.circular(
          20.0,
        ),
        highlightColor: Style.defaultColor.withOpacity(
          0.5,
        ),
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 55,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              20.0,
            ),
            gradient: LinearGradient(
              colors: [
                // Style.defaultColor,
                Style.defaultColor.withOpacity(
                  0.8,
                ),
                Style.defaultColor.withOpacity(
                  0.6,
                ),
                Style.defaultColor.withOpacity(
                  0.4,
                ),
                Style.defaultColor.withOpacity(
                  0.2,
                ),
                Style.defaultColor.withOpacity(
                  0.0,
                ),
              ],
              tileMode: TileMode.clamp,
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            // border: Border.all(
            //   color: Style.defaultColor,
            //   width: 1.0,
            // ),
          ),
          child: Row(
            children: [
              const SizedBox(
                width: 10.0,
              ),
              Icon(
                icon,
                size: 27,
              ),
              const SizedBox(
                width: 15.0,
              ),
              Text(
                text,
                style: const TextStyle(
                  fontFamily: Style.corbel,
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

//
//
//
//
//* bottom side "Explore" sections
//* all grid item method
  Widget exploreGridItems({
    required String text,
    required String assetImage,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(
        20.0,
      ),
      highlightColor: Style.defaultColor.withOpacity(
        0.7,
      ),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          // border: Border.all(
          //   color: Style.defaultColor,
          // ),
          gradient: LinearGradient(
            colors: [
              Style.defaultColor,
              Style.defaultColor.withOpacity(
                0.7,
              ),
              Style.defaultColor.withOpacity(
                0.5,
              ),
              Style.defaultColor.withOpacity(
                0.3,
              ),
              Style.defaultColor.withOpacity(
                0.1,
              ),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            tileMode: TileMode.clamp,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(
                10.0,
              ),
              child: Opacity(
                opacity: 0.1,
                child: Image.asset(
                  assetImage,
                ),
              ),
            ),
            Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: Style.ard,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

//
//
//
//
//* Sign in and Log in Button Methods---->
  Widget signLogButton(
      {required Color borderColor,
      required VoidCallback ontap,
      required String text}) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: ontap,
        borderRadius: BorderRadius.circular(
          30.0,
        ),
        highlightColor: Style.defaultColor.withOpacity(
          0.5,
        ),
        child: Container(
          alignment: Alignment.center,
          height: 42,
          width: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              30.0,
            ),
            border: Border.all(
              color: borderColor,
              width: 1.0,
            ),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 17,
              fontFamily: Style.corbel,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

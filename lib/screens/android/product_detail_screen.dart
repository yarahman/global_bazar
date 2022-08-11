import 'package:flutter/material.dart';

import '../../theme/style.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = 'productDetailScreen';
  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'this is the title',
          style: TextStyle(
            fontFamily: Style.ard,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.shopping_cart_outlined,
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ListView(
              children: [
                Container(
                  constraints: const BoxConstraints(maxHeight: 250),
                  width: double.infinity,
                  child: Image.network(
                    'https://images.pexels.com/photos/19090/pexels-photo.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 80.0,
                  color: Colors.grey,
                ),
                const Padding(
                  padding: EdgeInsets.all(
                    5.0,
                  ),
                  child: Text(
                    'ready to ship',
                    style: TextStyle(
                      fontFamily: Style.corbel,
                      color: Colors.grey,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 5.0),
                  child: Text(
                    'this is the short description for this product, you can use it many for with ganartiy ki shaat',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: Style.ard,
                      fontSize: 17.0,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 5.0,
                  ),
                  child: Row(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Icon(
                            Icons.star_border_rounded,
                          ),
                          Icon(
                            Icons.star_border_rounded,
                          ),
                          Icon(
                            Icons.star_border_rounded,
                          ),
                          Icon(
                            Icons.star_border_rounded,
                          ),
                          Icon(
                            Icons.star_border_rounded,
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 7.0,
                      ),
                      Container(
                        height: 20,
                        width: 0.5,
                        color: Style.isDark ? Colors.white : Colors.black,
                      ),
                      const SizedBox(
                        width: 6.0,
                      ),
                      const Text(
                        '0.0',
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontFamily: Style.ard,
                        ),
                      ),
                      const SizedBox(
                        width: 6.0,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          '(0 reviews)',
                          style: TextStyle(
                            fontFamily: Style.ard,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 6.0,
                      ),
                      const Text(
                        '- 3 orders',
                        style: TextStyle(
                          color: Colors.grey,
                          fontFamily: Style.ard,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Row(
                    children: const [
                      Text(
                        'price : ',
                        style: TextStyle(
                          fontFamily: Style.corbel,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        '\$500',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          fontFamily: Style.ard,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25.0,
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    left: 5.0,
                  ),
                  child: Text(
                    'Apply coupon to get discount',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
                Card(
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      30.0,
                    ),
                  ),
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'enter coupon',
                          border: InputBorder.none,
                          isDense: true,
                          filled: true,
                          fillColor: Style.isDark
                              ? const Color.fromARGB(255, 34, 34, 34)
                              : const Color.fromARGB(255, 214, 214, 214),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              30.0,
                            ),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(
                                0,
                                255,
                                255,
                                255,
                              ),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              30.0,
                            ),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(
                                0,
                                255,
                                255,
                                255,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          alignment: Alignment.center,
                          height: 48,
                          width: 90,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Style.isDark ? Colors.grey : Colors.black,
                          ),
                          child: const Text(
                            'Submit',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Style.isDark ? Colors.black : Colors.white,
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Divider(
                  color: Colors.grey,
                  height: 10,
                  thickness: 0.2,
                ),
                const SizedBox(
                  height: 15.0,
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    left: 5.0,
                  ),
                  child: Text(
                    'Processing time',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17.0,
                      fontFamily: Style.ard,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    left: 5.0,
                  ),
                  child: Text(
                    '7 Days',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                const Divider(
                  color: Colors.grey,
                  height: 10,
                  thickness: 0.2,
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 42,
                  width: MediaQuery.of(context).size.width * 0.35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      40.0,
                    ),
                    border: Border.all(
                      color: Style.isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  child: const Text(
                    'Chat Now',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: Style.ard,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  height: 42,
                  width: MediaQuery.of(context).size.width * 0.35,
                  decoration: BoxDecoration(
                    color: Style.defaultColor,
                    borderRadius: BorderRadius.circular(
                      40.0,
                    ),
                  ),
                  child: const Text(
                    'Start Order',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: Style.ard,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'make this favorite',
        elevation: 5.0,
        backgroundColor: Style.isDark ? Colors.grey : Colors.black,
        onPressed: () {},
        child: const Icon(
          Icons.favorite_border_rounded,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

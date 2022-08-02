import 'package:flutter/material.dart';

import '../../theme/style.dart';
import '../../screens/android/product_detail_screen.dart';

class OverviewProductItem extends StatelessWidget {
  const OverviewProductItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(ProductDetailScreen.routeName);
      },
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(
            color: Style.defaultColor.withOpacity(0.4),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: SizedBox(
                height: 180,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(
                      10.0,
                    ),
                    topRight: Radius.circular(
                      10.0,
                    ),
                  ),
                  child: Image.network(
                    'https://upload.wikimedia.org/wikipedia/commons/a/ae/Kawasaki_Ninja_H2R_Seattle_motorcycle_show.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            const Padding(
              padding: EdgeInsets.all(2.5),
              child: Text(
                'used kawasaki ninja h2r for ...',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 126, 126, 126),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(
              height: 7.0,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 2.5),
              child: Text(
                '\$500',
                style: TextStyle(
                  fontFamily: Style.ard,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 2.5,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.verified_outlined,
                    color: Colors.green.shade300,
                  ),
                  const SizedBox(
                    width: 3.0,
                  ),
                  Text(
                    'verified',
                    style: TextStyle(
                      fontFamily: Style.corbel,
                      color: Colors.green.shade300,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 3.0,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 7,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text(
                        'japan',
                        style: TextStyle(
                          fontFamily: Style.ard,
                          color: Colors.grey,
                          fontSize: 10.0,
                        ),
                      ),
                      const SizedBox(
                        width: 3.0,
                      ),
                      Container(
                        height: 9,
                        width: 0.5,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        width: 3.0,
                      ),
                      const Text(
                        '5yr',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontFamily: Style.corbel,
                          color: Colors.grey,
                          fontSize: 10.0,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                        },
                        child: Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Style.defaultColor,
                              borderRadius: BorderRadius.circular(
                                50.0,
                              ),
                            ),
                            child: const Icon(
                              Icons.add,
                              shadows: [
                                Shadow(
                                  color: Colors.grey,
                                  blurRadius: 7,
                                  offset: Offset(1, 1),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

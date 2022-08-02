import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

import '../../../theme/style.dart';
import '../../universal_widgets/your_business_item.dart';
import '../../universal_widgets/top_ranking_item.dart';
import '../../universal_widgets/overview_product_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
//* main column---->
        SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // searched text filed , image searched button , searched button ------------>
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                TextField(
                  cursorColor: Style.defaultColor,
                  decoration: InputDecoration(
                      isDense: true,
                      filled: true,
                      fillColor: Style.isDark
                          ? const Color.fromARGB(255, 73, 73, 73)
                          : const Color.fromARGB(
                              125,
                              224,
                              224,
                              224,
                            ),
                      border: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          50.0,
                        ),
                        borderSide: BorderSide(
                          width: 0.0,
                          color: Colors.white.withOpacity(
                            0.0,
                          ),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          50.0,
                        ),
                        borderSide: BorderSide(
                          width: 0.0,
                          color: Colors.white.withOpacity(
                            0.0,
                          ),
                        ),
                      ),
                      hintText: 'searched products'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.image_search_rounded,
                        color: Style.isDark ? Colors.white70 : Colors.black,
                      ),
                    ),
                    FloatingActionButton.small(
                      onPressed: () {},
                      backgroundColor:
                          Style.isDark ? Colors.white70 : Colors.black,
                      child: const Icon(
                        Icons.search_rounded,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          //end of searched text field , searched image button , searched button ------^
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 10.0,
                top: 20,
              ),
              child: ListView(
                children: [
// this column for your business items widget------->
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'For Your Business',
                        style: TextStyle(
                          fontFamily: Style.corbel,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      SizedBox(
                        height: 93.0,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            YourBusinessItem(
                                containerColor:
                                    const Color.fromARGB(255, 252, 143, 0),
                                icon: Icons.category_outlined,
                                iconColor:
                                    const Color.fromARGB(255, 255, 197, 122),
                                ontap: () {},
                                text: 'All Category'),
                            YourBusinessItem(
                              containerColor:
                                  const Color.fromARGB(255, 0, 94, 156),
                              text: 'Ready to ship',
                              icon: Icons.shopping_cart_checkout_sharp,
                              ontap: () {},
                              iconColor:
                                  const Color.fromARGB(255, 122, 202, 255),
                            ),
                            YourBusinessItem(
                              containerColor:
                                  const Color.fromARGB(255, 92, 0, 145),
                              text: 'Worldwide\nselection',
                              icon: Icons.webhook_sharp,
                              ontap: () {},
                              iconColor:
                                  const Color.fromARGB(255, 213, 155, 247),
                            ),
                            YourBusinessItem(
                              containerColor:
                                  const Color.fromARGB(255, 0, 189, 173),
                              text: 'Drop Shipping',
                              icon: Icons.check_box_outlined,
                              ontap: () {},
                              iconColor:
                                  const Color.fromARGB(255, 98, 247, 234),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
//end of the your business item widget column---------^
                  const SizedBox(
                    height: 20.0,
                  ),

// top ranking products widget column ---------->
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Top-Ranking',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: Style.corbel,
                            ),
                          ),
                          RotatedBox(
                            quarterTurns: 2,
                            child: IconButton(
                              icon: const Icon(Icons.arrow_back_rounded),
                              onPressed: () {},
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 260,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            TopRankingItem(
                              imageUrl:
                                  'https://media.wired.com/photos/6148ef98a680b1f2086efee0/1:1/w_1037,h_1037,c_limit/Gear-Review-Apple_iphone13_hero_us_09142021.jpg',
                              onTap: () {},
                              title: 'GSM used mobile phones',
                            ),
                            TopRankingItem(
                              imageUrl:
                                  'https://static-01.daraz.com.bd/p/f25822d5acc483ad4b3e29217fac12ee.jpg',
                              onTap: () {},
                              title: 'Gaming Computer Cases & Towers',
                            ),
                            TopRankingItem(
                              imageUrl:
                                  'https://images.meesho.com/images/products/89867327/hh4s5_512.jpg',
                              onTap: () {},
                              title: 'Used Shoes',
                            ),
                            TopRankingItem(
                              imageUrl:
                                  'https://cdn.shopify.com/s/files/1/0024/9803/5810/products/410699-Product-2-I-637242662468866066_1024x1024.jpg',
                              onTap: () {},
                              title: 'Used & New Sumsung Monitors',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
//end of top ranking product widget column ------------^
                  const SizedBox(
                    height: 30.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Just For You',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: Style.corbel,
                          fontSize: 18.0,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: ImageSlideshow(
                          width: double.infinity,
                          height: 250.0,
                          autoPlayInterval: 5000,
                          isLoop: true,
                          indicatorBackgroundColor: Colors.grey,
                          indicatorColor: Style.defaultColor,
                          initialPage: 0,
                          onPageChanged: (value) {},
                          children: [
                            Image.network(
                              'https://img.freepik.com/free-vector/hand-drawn-summer-sale-banner_23-2149413805.jpg?w=2000',
                            ),
                            Image.network(
                                'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/red-hot-sale-ad-design-template-50c431435f17035af3f80d10146feec3_screen.jpg?ts=1613509297'),
                            Image.network(
                                'https://res.cloudinary.com/powtoon-dev/image/fetch/w_864,h_486,f_auto,q_auto/https://library.powtoon.co/templates/v5/thumbs/pt617-Solve-your-problems1920x1080_ooJoZpn.jpg'),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisExtent: 335,
                          childAspectRatio: 3 / 2,
                          mainAxisSpacing: 2,
                          crossAxisSpacing: 2,
                        ),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return const OverviewProductItem();
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
//* end main column ---^
  }
}

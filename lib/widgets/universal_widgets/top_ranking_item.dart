import 'package:flutter/material.dart';

import '../../theme/style.dart';

class TopRankingItem extends StatelessWidget {
  const TopRankingItem(
      {required this.onTap, required this.imageUrl, required this.title});
  final VoidCallback onTap;
  final String title;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: SizedBox(
          width: 170,
          child: Card(
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                20.0,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Card(
                  elevation: 7.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      15.0,
                    ),
                  ),
                  child: SizedBox(
                    height: 200,
                    // width: 180,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        15.0,
                      ),
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: Style.ard,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                    shadows: [
                      Shadow(
                        color: Colors.grey,
                        blurRadius: 10,
                        offset: Offset(
                          4,
                          3,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 3.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

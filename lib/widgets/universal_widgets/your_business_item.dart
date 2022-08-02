import 'package:flutter/material.dart';

import '../../theme/style.dart';

class YourBusinessItem extends StatelessWidget {
  YourBusinessItem(
      {required this.containerColor,
      required this.icon,
      required this.iconColor,
      required this.ontap,
      required this.text});
  final VoidCallback ontap;
  final Color containerColor;
  final String text;
  final IconData icon;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: GestureDetector(
        onTap: ontap,
        child: Card(
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              15.0,
            ),
          ),
          child: Container(
            alignment: Alignment.center,
            width: 200.0,
            decoration: BoxDecoration(
              color: containerColor,
              borderRadius: BorderRadius.circular(
                15.0,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontFamily: Style.ard,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  icon,
                  color: iconColor,
                  size: 42,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

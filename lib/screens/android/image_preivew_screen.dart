import 'dart:io';

import 'package:flutter/material.dart';

import '../../theme/style.dart';

class ImagePreviewScreen extends StatelessWidget {
  const ImagePreviewScreen();
  static const routeName = 'imagePreviewScreen';

  @override
  Widget build(BuildContext context) {
    final imageFile = ModalRoute.of(context)!.settings.arguments as File;
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Center(
            child: SizedBox(
              child: Image.file(
                imageFile,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FloatingActionButton.small(
                  heroTag: 'back',
                  elevation: 5,
                  backgroundColor:
                      Style.isDark ? Colors.white70 : Colors.black87,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

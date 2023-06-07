import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import '../../components/app_bar.dart';

class FullScreenImageScreen extends StatelessWidget {
  final String imageUrl;
  final String title;

  const FullScreenImageScreen({
    super.key,
    required this.imageUrl,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, title: title),
      body: PhotoView(
        backgroundDecoration: const BoxDecoration(color: Colors.white),
        imageProvider: NetworkImage(imageUrl),
      ),
    );
  }
}

class Photo extends StatelessWidget {
  final String imageUrl;
  final String title;

  const Photo({super.key, required this.imageUrl, required this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => FullScreenImageScreen(
                imageUrl: imageUrl,
                title: title,
              ),
            ),
          );
        },
        child: Image.network(imageUrl, fit: BoxFit.cover),
      ),
    );
  }
}

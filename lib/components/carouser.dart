import 'package:flutter/material.dart';
import 'package:scroll_page_view/pager/page_controller.dart';
import 'package:scroll_page_view/pager/scroll_page_view.dart';

import '../screens/accessable/photo_view.dart';
import 'constants.dart';
import 'container.dart';

Widget carousel({
  required List<String> images,
  required String title,
  imageCard = container,
}) {
  if (images.length == 1) {
    return SizedBox(
      width: double.infinity,
      height: cardHeight,
      child: imageCard(
        Photo(imageUrl: images.first, title: title),
      ),
    );
  }

  return SizedBox(
    height: cardHeight,
    child: CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: SizedBox(
            height: cardHeight,
            width: double.infinity,
            child: ScrollPageView(
              controller: ScrollPageController(),
              checkedIndicatorColor: color,
              allowImplicitScrolling: true,
              delay: const Duration(seconds: 8),
              duration: const Duration(milliseconds: 500),
              children: images
                  .map<Widget>(
                    (image) => imageCard(
                      Photo(imageUrl: image, title: title),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ],
    ),
  );
}

import 'package:bookly/Features/home/presentation/views/widgets/custom_book_image_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class FeaturedBooksListViewLoadingIndicator extends StatelessWidget {
  const FeaturedBooksListViewLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer (
      child: SizedBox(
        height: MediaQuery.of(context).size.height * .3,
        child: ListView.builder(
          itemCount: 15,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: CustomBookImageLoadingIndicator(),
            );
          },
        ),
      ),
    );
  }
}

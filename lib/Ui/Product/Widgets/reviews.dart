import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:google_fonts_arabic/fonts.dart';

import 'package:provider/provider.dart';
import 'package:w3d/Providers/ReviewsProvider/reviews_provider.dart';
import 'package:woocommerce/models/product_review.dart';

// ignore: must_be_immutable
class Reviews extends StatelessWidget {
  final int productId;

  Reviews({Key key, this.productId}) : super(key: key);
  List<WooProductReview> reviews = [];

  Future<void> future(BuildContext context) async {
    reviews = await Provider.of<ReviewsProvider>(context, listen: false)
        .getProductReviews(
      context: context,
      productId: productId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: FutureBuilder(
        future: future(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ProfileShimmer();
          } else {
            return ListView.builder(
              itemCount: reviews.length,
              itemBuilder: (context, index) => ReviewItem(
                index: index + 1,
                review: reviews[index].review,
                userName: reviews[index].reviewer,
              ),
            );
          }
        },
      ),
    );
  }
}

class ReviewItem extends StatelessWidget {
  final String review;
  final String userName;
  final int index;

  const ReviewItem({Key key, this.review, this.userName, this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.black,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                index.toString(),
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName ?? "",
                textScaleFactor: 1,
                overflow: TextOverflow.fade,
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontFamily: ArabicFonts.Cairo,
                  package: 'google_fonts_arabic',
                  fontSize: 17,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                softWrap: true,
              ),
              Text(
                review ?? "",
                textScaleFactor: 1,
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontFamily: ArabicFonts.Cairo,
                  package: 'google_fonts_arabic',
                  fontSize: 17,
                  color: Colors.black,
                ),
                softWrap: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

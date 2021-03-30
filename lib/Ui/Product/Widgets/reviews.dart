import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:html/parser.dart' show parse;
import 'package:provider/provider.dart';
import 'package:woocommerce/models/product_review.dart';
//
import '../../../Providers/ReviewsProvider/reviews_provider.dart';

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
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 12,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "التعليقات",
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
          FutureBuilder(
            future: future(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return ListView.builder(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 6,
                  itemBuilder: (context, index) => Directionality(
                    textDirection: TextDirection.rtl,
                    child: ProfileShimmer(
                      margin: EdgeInsets.zero,
                      padding: EdgeInsets.symmetric(vertical: 4),
                    ),
                  ),
                );
              } else {
                return Consumer<ReviewsProvider>(
                  builder: (context, value, child) {
                    reviews = value.reviews;
                    return ListView.builder(
                      physics: ScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                        vertical: 0,
                      ),
                      shrinkWrap: true,
                      itemCount: reviews.length,
                      itemBuilder: (context, index) => Column(
                        children: [
                          ReviewItem(
                            index: index + 1,
                            wooProductReview: reviews[index],
                          ),
                          index + 1 == reviews.length
                              ? Container()
                              : Divider(
                                  endIndent: 50,
                                  indent: 50,
                                  thickness: 1,
                                  color: Colors.grey,
                                ),
                        ],
                      ),
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class ReviewItem extends StatelessWidget {
  final WooProductReview wooProductReview;
  final int index;

  const ReviewItem({Key key, this.wooProductReview, this.index})
      : super(key: key);
  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString = parse(document.body.text).documentElement.text;

    return parsedString;
  }

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                wooProductReview.reviewer != null
                    ? wooProductReview.reviewer
                    : "",
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
                wooProductReview.review != null
                    ? _parseHtmlString(wooProductReview.review.trim())
                    : "",
                textScaleFactor: 1,
                overflow: TextOverflow.fade,
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontFamily: ArabicFonts.Cairo,
                  package: 'google_fonts_arabic',
                  fontSize: 17,
                  color: Colors.black,
                ),
                softWrap: true,
              ),
              wooProductReview.rating == null
                  ? Container()
                  : Row(
                      children: List.generate(
                        wooProductReview.rating,
                        (index) => Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                      ),
                    ),
            ],
          ),
        ],
      ),
    );
  }
}

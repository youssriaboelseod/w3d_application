import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
//
import '../../1MainHelper/Alerts/alerts.dart';
import '../../1MainHelper/Snacks/snackbar.dart';
import '../../../Providers/ReviewsProvider/reviews_provider.dart';
import '../../../Providers/AuthDataProvider/auth_data_provider.dart';

void showAddReviewForm({BuildContext context, int productId}) {
  final _titleController = TextEditingController(text: "");
  double rating = 5;
  bool checkIfSignedIn =
      Provider.of<AuthDataProvider>(context, listen: false).checkIfSignedIn();
  if (!checkIfSignedIn) {
    showTopSnackBar(
      context: context,
      body: "من فضلك قم بالتسجيل اولا",
      title: "تنبيه",
    );
    return;
  }
  showModalBottomSheet(
    backgroundColor: Colors.grey[300],
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(
          25.0,
        ),
      ),
    ),
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return GestureDetector(
        onTap: () {},
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    25,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 8,
                    left: 8,
                    right: 15,
                    bottom: 8,
                  ),
                  child: TextField(
                    minLines: 1,
                    maxLines: 2,
                    controller: _titleController,
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      enabledBorder: InputBorder.none,
                      border: InputBorder.none,
                      errorBorder: InputBorder.none,
                      hintText: "ادخل تقيمك",
                    ),
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              RatingBar.builder(
                initialRating: 5,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 5),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (ratingInp) {
                  rating = ratingInp;
                },
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    20,
                  ),
                ),
                onPressed: () async {
                  if (_titleController.text.isEmpty) {
                    showAlertNoAction(
                      context: context,
                      message: "من فضلك ادخل تقيمك",
                    );
                    return;
                  }
                  FocusScope.of(context).unfocus();

                  showTopSnackBar(
                    context: context,
                    title: "انتظر لحظات",
                    body: "جاري اضافة تقيمك",
                  );

                  String output =
                      await Provider.of<ReviewsProvider>(context, listen: false)
                          .createReview(
                    context: context,
                    rating: rating.toInt(),
                    productId: productId,
                    review: _titleController.text.trim(),
                  );
                  if (output != null) {
                    showAlertNoAction(
                      context: context,
                      message: output,
                    );

                    return;
                  } else {
                    showTopSnackBar(
                      context: context,
                      title: "رائع",
                      body: "تمت اضافة تقيمك بنجاح",
                    );
                    Navigator.of(context).pop();
                    return;
                  }
                },
                color: Colors.black,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    "اضافة",
                    textScaleFactor: 1,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      fontFamily: ArabicFonts.Cairo,
                      package: 'google_fonts_arabic',
                      fontSize: 18.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

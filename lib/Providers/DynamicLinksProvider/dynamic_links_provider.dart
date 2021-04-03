import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DynamicLinksProvider with ChangeNotifier {
  bool isOpenedDynamicLink = false;

  Future<String> createAndGetDynamicLink({
    String itemId,
    String itemName,
    Uri itemUrl,
  }) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://w3dapp.page.link',
      link: Uri.parse('https://050saa.com/?id=$itemId'),
      androidParameters: AndroidParameters(
        packageName: 'com.moadawy.W3d',
        minimumVersion: 2,
      ),
      iosParameters: IosParameters(
        bundleId: 'com.moadawy.W3d',
        minimumVersion: '1',
        appStoreId: '123456789',
      ),
      googleAnalyticsParameters: GoogleAnalyticsParameters(
        campaign: 'example-promo',
        medium: 'social',
        source: 'orkut',
      ),
      itunesConnectAnalyticsParameters: ItunesConnectAnalyticsParameters(
        providerToken: '123456',
        campaignToken: 'example-promo',
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
        title: 'الواعد',
        description: itemName,
        imageUrl: itemUrl,
      ),
    );

    final ShortDynamicLink shortDynamicLink = await parameters.buildShortLink();

    final Uri shortUrl = shortDynamicLink.shortUrl;
    final String productDynamicLink = shortUrl.toString();
    return productDynamicLink;
  }

  void setIsOpenedDynamicLink() {
    isOpenedDynamicLink = true;
  }
}

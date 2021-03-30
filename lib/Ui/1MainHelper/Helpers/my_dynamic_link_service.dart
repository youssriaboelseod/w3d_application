import 'package:flutter/material.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class MyDynamicLinkService {
  DynamicLinkParameters createDynamicLinkFunction(String id) {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://w3dapp.page.link',
      link: Uri.parse('https://050saa.com/?id=$id'),
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
        title: 'تطبيق الواعد',
        description: 'الواعد سوق للجميع',
      ),
    );
    return parameters;
  }
}

//final Uri dynamicUrl = await parameters.buildUrl();

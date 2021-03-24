import '../../Database/app_database.dart';

import 'package:flutter/cupertino.dart';

class AppConfigurationsProvider with ChangeNotifier {
  // AppConfigurations
  int version;
  String language;
  DateTime updateProductsDate;

  // To update the version increment newVersion
  final int newVersion = 24;

  bool checkIfNeedToUpdateProducts() {
    if (updateProductsDate == null) {
      return false;
    } else if (updateProductsDate.isBefore(DateTime.now())) {
      return false;
    } else {
      return true;
    }
  }

  Future<void> fetchAndSetTable() async {
    List<Map<String, dynamic>> outputData;
    outputData = await AppDB.getData("AppConfigurations");

    if (outputData.length == 0) {
      await setAppConfigurationsTable();
    } else if (outputData.length > 1) {
      // re-install the app
    } else {
      outputData.forEach((element) {
        version = element["version"];
        language = element["language"];
        updateProductsDate = element["updateProductsDate"] == null
            ? null
            : DateTime.parse(element["updateProductsDate"]);
      });
      // Warning
      // (version != newVersion) used to update version of the application
      if (version != newVersion) {
        updateVersion();
      }
    }
  }

  Future<void> setAppConfigurationsTable() async {
    await AppDB.insert(
      "AppConfigurations",
      {
        "version": newVersion,
        "language": null,
        "updateProductsDate": null,
      },
    );
    version = newVersion;
  }

  Future<void> setLangauge(String langaugeName) async {
    await AppDB.update(
      table: "AppConfigurations",
      data: {
        "language": langaugeName,
      },
      whereStatement: null,
      whereValue: null,
    );
    language = langaugeName;
    notifyListeners();
  }

  String get selectedLangauge {
    return language;
  }

  Future<void> updateVersion() async {
    // This suppose to be the version number of the new version
    await AppDB.update(
      table: "AppConfigurations",
      data: {
        "version": newVersion,
      },
      whereStatement: null,
      whereValue: null,
    );
    version = newVersion;
    notifyListeners();
  }

  Future<void> setUpdateProductsDate() async {
    DateTime tempDate = DateTime.now().add(Duration(days: 1));
    await AppDB.update(
      table: "AppConfigurations",
      data: {
        "updateProductsDate": tempDate.toIso8601String(),
      },
      whereStatement: null,
      whereValue: null,
    );
    updateProductsDate = tempDate;
    notifyListeners();
  }

  Future<void> clearUpdateProductsDate() async {
    await AppDB.update(
      table: "AppConfigurations",
      data: {
        "updateProductsDate": null,
      },
      whereStatement: null,
      whereValue: null,
    );
    updateProductsDate = null;
    notifyListeners();
  }
}

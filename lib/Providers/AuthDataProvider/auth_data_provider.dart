import '../../Database/app_database.dart';

import 'package:flutter/cupertino.dart';
import '../../Models/UserAuthModel/user_auth_model.dart';

class AuthDataProvider with ChangeNotifier {
  // AuthData
  UserAuthModel currentUser;

  bool checkIfSignedIn() {
    if (currentUser.id == null) {
      return false;
    } else {
      return true;
    }
  }

  Future<void> fetchAndSetTable() async {
    List<Map<String, dynamic>> outputData;

    outputData = await AppDB.getData("AuthData");
    print(outputData);

    if (outputData.length == 0) {
      await setAuthDataTable();
    } else if (outputData.length > 1) {
      // re-install the app
    } else {
      currentUser = UserAuthModel.fromAppDatabase(
        map: outputData[0],
      );
    }
  }

  Future<void> setAuthDataTable() async {
    currentUser = UserAuthModel.getEmptyUserAuthModel();
    await AppDB.insert(
      "AuthData",
      currentUser.toAppDatabase(),
    );
  }

  Future<void> updateAuthDataTable({
    UserAuthModel userAuthModelInp,
  }) async {
    await AppDB.update(
      table: "AuthData",
      data: userAuthModelInp.toAppDatabase(),
      whereStatement: null,
      whereValue: null,
    );
    currentUser = userAuthModelInp;
  }

  Future<void> updatePhoneNumberInAuthDataTable({
    String phoneNumberInp,
  }) async {
    await AppDB.update(
      table: "AuthData",
      data: {
        "phoneNumber": phoneNumberInp,
      },
      whereStatement: null,
      whereValue: null,
    );
    await fetchAndSetTable();
    notifyListeners();
  }

  Future<void> updateUserOrderInforInAuthDataTable({
    String firstNameInp,
    String lastNameInp,
    String cityInp,
    String addressInp,
    String locationInp,
  }) async {
    await AppDB.update(
      table: "AuthData",
      data: {
        "address": addressInp,
        "city": cityInp,
        "firstName": firstNameInp,
        "lastName": lastNameInp,
        "location": locationInp,
      },
      whereStatement: null,
      whereValue: null,
    );
    await fetchAndSetTable();
    notifyListeners();
  }

  Future<void> updatestoreNameInAuthDataTable({
    String storeNameInp,
  }) async {
    await AppDB.update(
      table: "AuthData",
      data: {
        "storeName": storeNameInp,
      },
      whereStatement: null,
      whereValue: null,
    );
    await fetchAndSetTable();
    notifyListeners();
  }

  Future<void> clearAuthDataTable() async {
    currentUser = UserAuthModel.getEmptyUserAuthModel();
    await AppDB.update(
      table: "AuthData",
      data: currentUser.toAppDatabase(),
      whereStatement: null,
      whereValue: null,
    );
  }
}

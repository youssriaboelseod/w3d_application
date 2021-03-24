import 'package:flutter/material.dart';

final List<Map> mainCategories = [
  {
    "id": "0",
    "name": "الكل",
  },
  {
    "id": "154",
    "name": "فنون",
  },
  {
    "id": "198",
    "name": "أعمال يدوية",
  },
  {
    "id": "152",
    "name": "طباعة حرارية",
  },
  {
    "id": "151",
    "name": "أحجار كريمة",
  },
  {
    "id": "149",
    "name": "أخرى",
  },
];

List<String> getCategoriesNames() {
  List<String> tempList = [];
  tempList.clear();
  mainCategories.forEach((element) {
    tempList.add(element["name"]);
  });
  tempList.removeAt(0);
  return tempList;
}

String getCategoryId({String nameInp}) {
  return mainCategories
      .firstWhere((element) => element["name"] == nameInp)["id"];
}

List<Map> colorsNames = [
  {
    "key": "blue-background",
    "value": "خلفية زرقاء",
  },
  {
    "key": "golden",
    "value": "ذهبي",
  },
  {
    "key": "white",
    "value": "أبيض",
  },
  {
    "key": "black",
    "value": "أسود",
  },
  {
    "key": "yellow",
    "value": "اصفر",
  },
  {
    "key": "red",
    "value": "أحمر",
  },
  {
    "key": "colored",
    "value": "ملون",
  },
  {
    "key": "black-background",
    "value": "خلفية سوداء",
  },
];
String getColorKey(String valueInp) {
  Map out = colorsNames.firstWhere((element) => element["value"] == valueInp);
  return out["key"];
}

String getColorValue(String keyInp) {
  Map out = colorsNames.firstWhere((element) => element["key"] == keyInp);
  return out["value"];
}

String getTypeValue(String inp) {
  if (inp == "male") {
    return "رجالي";
  } else if (inp == "female") {
    return "نسائي";
  } else {
    return "";
  }
}

enum PaymentMethods {
  bank,
  stcPay,
  paypal,
}
List<String> paymentMethodsList = [
  "alg_custom_gateway_1",
  "bacs",
  "cod",
];
List<String> paymentMethodTitlesList = [
  "الدفع عن طريق STC Pay",
  "حوالة مصرفية مباشرة",
  "PayPal",
];

class UserAuthModel {
  String userName;
  String storeName;
  String email;
  String password;
  String id;
  String phoneNumber;

  Map<String, dynamic> toAppDatabase() {
    return {
      "email": email,
      "id": id,
      "password": password,
      "phoneNumber": phoneNumber,
      "storeName": storeName,
      "userName": userName,
    };
  }

  UserAuthModel({
    this.email,
    this.storeName,
    this.password,
    this.phoneNumber,
    this.id,
    this.userName,
  });

  factory UserAuthModel.getEmptyUserAuthModel() {
    return UserAuthModel(
      userName: null,
      storeName: null,
      email: null,
      password: null,
      phoneNumber: null,
      id: null,
    );
  }

  factory UserAuthModel.fromAppDatabase({Map<String, dynamic> map}) {
    return UserAuthModel(
      email: map["email"],
      id: map["id"],
      password: map["password"],
      phoneNumber: map["phoneNumber"],
      storeName: map["storeName"],
      userName: map["userName"],
    );
  }

  factory UserAuthModel.fromWooCommerce(
      {Map<String, dynamic> map, String passwordInp}) {
    return UserAuthModel(
      id: map["ID"].toString(),
      userName: map["data"]["user_login"],
      email: map["data"]["user_email"],
      password: passwordInp,
      storeName: map["data"]["user_nicename"],
      phoneNumber: "",
    );
  }
}

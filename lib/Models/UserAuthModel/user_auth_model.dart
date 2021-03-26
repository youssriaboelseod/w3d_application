class UserAuthModel {
  String userName;
  String storeName;
  String email;
  String password;
  String id;
  String phoneNumber;
  String firstName;
  String lastName;
  String city;
  String address;
  String location;

  Map<String, dynamic> toAppDatabase() {
    return {
      "email": email,
      "id": id,
      "password": password,
      "phoneNumber": phoneNumber,
      "storeName": storeName,
      "userName": userName,
      "address": address,
      "city": city,
      "firstName": firstName,
      "lastName": lastName,
      "location": location,
    };
  }

  UserAuthModel({
    this.email,
    this.storeName,
    this.password,
    this.id,
    this.userName,
    this.phoneNumber = "",
    this.firstName = "",
    this.lastName = "",
    this.city = "",
    this.address = "",
    this.location = "",
  });

  factory UserAuthModel.getEmptyUserAuthModel() {
    return UserAuthModel(
      userName: null,
      storeName: null,
      email: null,
      password: null,
      phoneNumber: null,
      id: null,
      address: null,
      city: null,
      firstName: null,
      lastName: null,
      location: null,
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
      address: map["address"],
      city: map["city"],
      firstName: map["firstName"],
      lastName: map["lastName"],
      location: map["location"],
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
    );
  }
}

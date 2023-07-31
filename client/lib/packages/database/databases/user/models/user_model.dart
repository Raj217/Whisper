part of database;

class UserModel {
  bool admin;
  bool emailVerified;
  String firstName;
  String? lastName;
  DateTime randomImagesLastViewedCheckpoint;

  UserModel({
    this.admin = false,
    this.emailVerified = false,
    required this.firstName,
    this.lastName,
    DateTime? randomImagesLastViewedCheckpoint,
  }) : randomImagesLastViewedCheckpoint = randomImagesLastViewedCheckpoint ??
            DateTime.fromMillisecondsSinceEpoch(0);

  @override
  String toString() {
    return "User(\n"
        "admin: $admin,\n"
        "emailVerified: $emailVerified,\n"
        "firstName: $firstName,\n"
        "lastName: $lastName,\n"
        "randomImagesLastViewedCheckpoint: $randomImagesLastViewedCheckpoint\n"
        ")";
  }

  dynamic toJson() {
    Map<String, dynamic> data = {
      'isAdmin': admin,
      'emailVerified': emailVerified,
      'firstName': firstName,
      'randomImagesLastViewedCheckpoint':
          randomImagesLastViewedCheckpoint.millisecondsSinceEpoch
    };
    if (lastName != null) {
      data['lastName'] = lastName;
    }
    return data;
  }

  static UserModel fromDocSnapshot(QueryDocumentSnapshot userData) {
    if (!userData.exists || userData.data() == null) {
      throw Exception(
        releaseMessage: "Couldn't find User",
        debugMessage: "User doesn't exist",
      );
    } else {
      Map userDataMap = userData.data()! as Map;
      return UserModel(
        admin: userDataMap['admin'],
        emailVerified: userDataMap['emailVerified'],
        firstName: userDataMap['firstName'],
        lastName: userDataMap['lastName'],
        randomImagesLastViewedCheckpoint: DateTime.fromMillisecondsSinceEpoch(
          userDataMap['randomImagesLastViewedCheckpoint'],
        ),
      );
    }
  }
}

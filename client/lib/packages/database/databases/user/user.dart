part of database;

class UserDatabase {
  static CollectionReference _getCollection() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    return firestore.collection(UserCollections.users.name);
  }

  static Future<DocumentSnapshot> _getDocumentSnapshot() async {
    CollectionReference collectionReference = _getCollection();
    String? email = _currentUser.email;
    return await collectionReference.doc(email).get();
  }

  static Future<UserModel> getCurrentUser() async {
    QuerySnapshot snapshot = await _getCollection().get();
    QueryDocumentSnapshot userData = snapshot.docs.firstWhere(
        (doc) => doc.id == FirebaseAuth.instance.currentUser!.email);

    return UserModel.fromDocSnapshot(userData);
  }

  static Future<void> updateLastViewedCheckpoint({
    required DateTime newCheckpoint,
  }) async {
    DateTime prevCheckpoint =
        (await getCurrentUser()).randomImagesLastViewedCheckpoint;
    if (newCheckpoint > prevCheckpoint) {
      DocumentSnapshot doc = await _getDocumentSnapshot();

      if (doc.exists) {
        CollectionReference collectionReference = _getCollection();

        await collectionReference.doc(_currentUser.email).update({
          "randomImagesLastViewedCheckpoint":
              newCheckpoint.millisecondsSinceEpoch
        });
      }
    }
  }

  static User get _currentUser {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      throw Exception(
          debugMessage: "Current user not found",
          releaseMessage: "User not found. Please Login or Sign up again");
    }
    return currentUser;
  }

  static Future<void> createUser() async {
    User currentUser = _currentUser;
    CollectionReference collectionReference = _getCollection();
    String? email = currentUser.email;

    DocumentSnapshot userDoc = await collectionReference.doc(email).get();
    // If user doesn't exists create the user in firebase database
    if (!userDoc.exists) {
      String? firstName, lastName;
      if (currentUser.displayName == null) {
        firstName = "Unknown";
      } else {
        List<String> name = currentUser.displayName!.split(" ");
        firstName = name[0];
        if (name.length > 1) {
          lastName = name.sublist(1).join(" ");
        }
      }
      UserModel user = UserModel(
        emailVerified: currentUser.emailVerified,
        firstName: firstName,
        lastName: lastName,
      );

      await collectionReference.doc(email).set(user.toJson());
    }
  }
}

enum UserCollections { users }

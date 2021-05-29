part of 'services.dart';

class UsersServices {
  static CollectionReference _usersServices =
      FirebaseFirestore.instance.collection('users');
  static Future<void> updateUser(Users user) async {
    try {
      await _usersServices.doc(user.id).set(
            user.toJson(),
          );
    } on FirebaseException catch (e) {
      print('Terjadi error : ' + e.message);
    }
  }

  static Users _getUserDoc(DocumentSnapshot document) {
    return Users.fromSnapshot(document);
  }

  static List<Users> _getUserColl(QuerySnapshot snapshot) {
    return snapshot.docs.map((e) => Users.fromSnapshot(e)).toList();
  }

  static Stream<Users> getUserDoc(String id) {
    return _usersServices.doc(id).snapshots().map(_getUserDoc);
  }

  static Stream<List<Users>> getUserColl() {
    return _usersServices.snapshots().map(_getUserColl);
  }
}

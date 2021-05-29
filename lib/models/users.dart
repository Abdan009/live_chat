part of 'models.dart';

class Users {
  final String id, name, email, photoProfile;
  Users({
    this.id,
    @required this.name,
    @required this.email,
    @required this.photoProfile,
  });

  Users copyWith({
    String name,
    String email,
    String photoProfile,
  }) {
    return Users(
      id: this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      photoProfile: photoProfile ?? this.photoProfile,
    );
  }

  factory Users.fromSnapshot(DocumentSnapshot snapshot) {
    return Users(
      id: snapshot.id,
      name: snapshot['name'],
      email: snapshot['email'],
      photoProfile: snapshot['photoProfile'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'name': this.name,
      'email': this.email,
      'photoProfile': this.photoProfile,
    };
  }
}

Users myUser;

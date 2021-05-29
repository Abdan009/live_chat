part of 'services.dart';

class AuthEmailServices {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<SignInSignOutResult> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      await userCredential.user.sendEmailVerification();
      Users user = Users(
        id: userCredential.user.uid,
        name: userCredential.user.displayName,
        email: userCredential.user.email,
        photoProfile: userCredential.user.photoURL,
      );
      await UsersServices.updateUser(user);
      myUser = user;
      return SignInSignOutResult(user: user);
    } on FirebaseAuthException catch (e) {
      return SignInSignOutResult(message: e.toString());
    }
  }

  static Future<void> signOut() async {
    await _auth.signOut();
  }
}

class SignInSignOutResult {
  final Users user;
  final String message;

  SignInSignOutResult({this.user, this.message});
}

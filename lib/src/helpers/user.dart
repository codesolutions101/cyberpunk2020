import 'package:firebase_auth/firebase_auth.dart';

class User {
  final String uid;

  User({this.uid});
}

class UserData {
  final String uid;
  final String displayName;
  final String email;
  final String password;
  final String createdAt;
  final bool isAdmin;

  UserData({
    this.uid,
    this.displayName,
    this.email,
    this.password,
    this.createdAt,
    this.isAdmin,
  });
}

class AuthService {
  FirebaseAuth auth = FirebaseAuth.instance;
  User userFromFireBaseUser(FirebaseUser user) {
    print(user);
    return user != null ? User(uid: user.uid) : null;
  }

  Stream<User> get user {
    return auth.onAuthStateChanged.map(userFromFireBaseUser);
  }

  UserData userDataFromFireBaseUser(FirebaseUser user) {
    return user != null ? UserData(uid: user.uid) : null;
  }

  Stream<UserData> get userData {
    return auth.onAuthStateChanged.map(userDataFromFireBaseUser);
  }

  // sign out
  Future<void> signOut() async {
    try {
      await auth.signOut();
    } catch (error) {
      print(error.toString());
    }
  }
}

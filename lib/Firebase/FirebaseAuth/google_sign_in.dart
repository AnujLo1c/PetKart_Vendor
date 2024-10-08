import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../MyWidgets/snackbarAL.dart';



// steps
/*
firebase app
authentication enabel
ssh code update
relocate new files
flutterfire config
com.anuj.temp

in main function--
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
  options:DefaultFirebaseOptions.currentPlatform
);
  runApp(const MyApp());
 */

class GoogleSignInAL{

FirebaseAuth auth=FirebaseAuth.instance;
    final GoogleSignIn googleSignIn=GoogleSignIn();

  Future<UserCredential?> signInGoogle() async {
    try {
      print("1");
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn
          .signIn();
      if (googleSignInAccount != null) {
      print("2");
        final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
        final AuthCredential authCredential = GoogleAuthProvider.credential(
            idToken: googleSignInAuthentication.idToken,
            accessToken: googleSignInAuthentication.accessToken);

      print("3");
        UserCredential userCredential = await auth.signInWithCredential(authCredential);
        User? user = userCredential.user;
      print("4");
        if (user != null) {

          return userCredential;
        }
      }
      return null;
    }
    catch (e){
      showErrorSnackbar(e.toString()  );
      print(e.toString());
      return null;
    }
  }
  Future<bool> signOutGoogle() async {
    try {
      await auth.signOut();
      await googleSignIn.signOut();
    return true;
    }
    catch(e){
      return false;
    }
    }
}


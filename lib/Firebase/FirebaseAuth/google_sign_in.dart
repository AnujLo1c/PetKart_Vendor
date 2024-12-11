import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../MyWidgets/snackbarAL.dart';

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
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn
          .signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
        final AuthCredential authCredential = GoogleAuthProvider.credential(
            idToken: googleSignInAuthentication.idToken,
            accessToken: googleSignInAuthentication.accessToken);
        UserCredential userCredential = await auth.signInWithCredential(authCredential);
        User? user = userCredential.user;
        if (user != null) {
          return userCredential;
        }
      }
      return null;
    }
    catch (e){
      showErrorSnackbar(e.toString());
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


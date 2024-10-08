import 'package:cloud_firestore/cloud_firestore.dart';

import '../../Models/customer.dart';


class FirestoreFirebaseAL{
  FirebaseFirestore ff=FirebaseFirestore.instance;
  uploadUserDataAL(Customer cu) async {
    try{
await ff.collection("users").doc(cu.email).set(cu.toMap());
      print("user profile data success");
    return true;
    }
    catch(e){
      print("user data firebasefirestore upload failed");
      return false;
    }
  }

  deleteUserDataAl(String? docName) async {
    try{
      await ff.collection("users").doc(docName).delete();
      print("user profile data delete success");
      return true;
    }
    catch(e){
      print("user data firebasefirestore delete failed");
      return false;
    }
  }

}
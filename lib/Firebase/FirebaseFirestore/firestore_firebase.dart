import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petkart_vendor/Models/income_model.dart';

import '../../Models/customer.dart';


class FirestoreFirebaseAL{
  FirebaseFirestore ff=FirebaseFirestore.instance;
  uploadUserDataAL(Customer cu) async {
    try{
      IncomeModel incomeModel=IncomeModel();
await ff.collection("vendorusers").doc(cu.email).set(cu.toMap());
await ff.collection("vendorusers").doc(cu.email).update(incomeModel.toMap());
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:engage/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthService{
  final _auth = FirebaseAuth.instance;

  Future<User?> createUserWithEmailAndPassowrd(String email,String password,String username) async{
    try{
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Send Verification Email
      User? user = userCredential.user;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification ();

        CollectionReference users = FirebaseFirestore.instance.collection('users');

        await users.doc(user.email).set({
          "email": user.email,
          "username": username,
          "uid": user.uid,
          "role":"USER" // by default
        });

        showToast(message: 'Verification email sent. Please check your inbox.');
      }
      return user ;
    } on FirebaseAuthException catch(e) {
      if(e.code == 'email-already-in-use'){
        showToast(message: 'The user with this email address is already exists');
      }else{
       showToast(message: 'An error occured: ${e.code}');
      }
    }
    return null ;
  }

  /// todo - signup using link verify will do later
  // Future<User?> signUpUsingVerifyLink(String email,String password) async{
  //   try{
  //     final cred = await _auth.signInWithEmailLink(email: email, emailLink: '');
  //     return  cred.user;
  //   }catch(e){
  //     Fluttertoast.showToast(msg: 'Something Went Wrong');
  //   }
  //   return null ;
  // }

  Future<User?> logInUserWithEmailAndPassowrd(String email,String password) async{
    try{
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;
      if (user != null && !user.emailVerified) {
        showToast(message: 'Email is not verified. Please check your inbox.');
      }else if (user != null && user.emailVerified){
        return user ;
      }
    } on FirebaseAuthException catch(e) {
      if(e.code == 'user-not-found' || e.code =='wrong-password'){
        showToast(message: 'Invalid email or password.');
      }else{
        showToast(message: 'An error occured: ${e.code}');
      }
    }
    return null ;
  }

  Future<void> signOutUser() async{
    try{
      await _auth.signOut();
    }catch(e){
      Fluttertoast.showToast(msg: 'Something Went Wrong');
    }
  }


}
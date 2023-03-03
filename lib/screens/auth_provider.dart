import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:save_task/screens/bottom_controller.dart';
import 'package:save_task/screens/login_screen/login_screen.dart';
import 'package:save_task/screens/login_screen/varifycode.dart';
import 'package:save_task/utilities/util.dart';

class AuthenticationService with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  signUp(String email, String password, BuildContext context) async {
    setLoading(true);
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      setLoading(false);
      Navigator.push(context, MaterialPageRoute(builder: ((context) => BottomScreenController())));
      Util().showToast('SignUp Successfully');
    } on FirebaseAuthException catch (error) {
      setLoading(false);
      Util().showToast(error.message.toString());
    }
  }

  login(String email, String password, BuildContext context) async {
    setLoading(true);
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      setLoading(false);
      Navigator.push(context, MaterialPageRoute(builder: ((context) => BottomScreenController())));
      Util().showToast('Login SuccessFully');
    } on FirebaseAuthException catch (error) {
      setLoading(false);
      Util().showToast(error.message.toString());
    }
  }

  signUpWithGoogle(BuildContext context) async {
    try {
      //signup to google
      GoogleSignInAccount? googleSignAccount = await googleSignIn.signIn();
      if (googleSignAccount != null) {
        GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignAccount.authentication;
        AuthCredential credential = GoogleAuthProvider.credential(
            idToken: googleSignInAuthentication.idToken,
            accessToken: googleSignInAuthentication.accessToken);
        //then sign to firebase
        try {
          UserCredential userCredential =
              await auth.signInWithCredential(credential);
          Navigator.push(context, MaterialPageRoute(builder: ((context) => BottomScreenController())));
          Util().showToast('Login SuccessFully');
        } catch (e) {
          Util().showToast(e.toString());
        }
      } else {
        Util().showToast('Unable to Login');
      }
    } on FirebaseAuthException catch (error) {
      Util().showToast(error.message.toString());
    }
  }

  logOut(BuildContext context) {
    try {
      auth.signOut();
      googleSignIn.signOut();
      Util().showToast('Log out succesfully');
      Navigator.push(context, MaterialPageRoute(builder: ((context) => LoginScreen())));
    } on FirebaseAuthException catch (error) {
      Util().showToast(error.message.toString());
    }
  }

  forgottPassword(BuildContext context, String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      Util().showToast(
          'We have send you an email for recover the password, \n please check the email');
    } on FirebaseAuthException catch (error) {
      Util().showToast(error.message.toString());
    }
  }

  loginWithPhoneNumber(BuildContext context, String number)async{
    try {
                    await auth.verifyPhoneNumber(
                        phoneNumber: number,
                        verificationCompleted: (context) {
                         setLoading(false);
                        },
                        verificationFailed: (e) {
                          setLoading(false);
                          Util().showToast(e.toString());
                        },
                        codeSent: (String verifcationId, int? token) {
                          Navigator.push(context,
                              MaterialPageRoute(builder: ((context) {
                            return VarifyCodeScreen(
                              varificationId: verifcationId,
                            );
                          })));
                         setLoading(false);
                        },
                        codeAutoRetrievalTimeout: (e) {
                          Util().showToast(e.toString());
                        });
                    setLoading(false);
                  } on FirebaseAuthException catch (error) {
                    Util().showToast(error.message.toString());
                  }
  }
  
}

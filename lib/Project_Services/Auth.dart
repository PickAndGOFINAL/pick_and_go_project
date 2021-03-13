import 'package:firebase_auth/firebase_auth.dart';

class Auth{

  final _auth  =FirebaseAuth.instance;



  Future<AuthResult>SignUp(String email, String passoword) async

  {

  final MyAuthResult = await  _auth.createUserWithEmailAndPassword(email: email, password: passoword);
  return MyAuthResult;
  }

  Future<AuthResult>SignIn(String email, String passoword) async

  {

    final MyAuthResult = await  _auth.signInWithEmailAndPassword(email: email, password: passoword);
    return MyAuthResult;
  }




}
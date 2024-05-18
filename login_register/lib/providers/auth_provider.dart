import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum StateLogin { initial, success, error }

class AuthProvider with ChangeNotifier {
  final formKeyLogin = GlobalKey<FormState>();
  final formKeyRegister = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  var loginState = StateLogin.initial;
  var phone = '';
  var uid = '';
  var messageError = '';

  void processLogin(BuildContext context) async {
    if (formKeyLogin.currentState?.validate() ?? false) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);
        loginState = StateLogin.success;
        uid = userCredential.user?.uid ?? '';
        notifyListeners();
        _showSuccessDialog(context, 'Login Successful', 'Your UID: $uid');
      } on FirebaseAuthException catch (e) {
        loginState = StateLogin.error;
        messageError = e.message ?? 'An unknown error occurred';
        notifyListeners();

        String errorMessage;
        if (e.code == 'user-not-found') {
          errorMessage = 'No user found for that email.';
        } else if (e.code == 'wrong-password') {
          errorMessage = 'Wrong password provided for that user.';
        } else {
          errorMessage = 'Login failed. Please try again.';
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill out the form correctly.')),
      );
    }
  }

  void processRegister(BuildContext context) async {
    if (formKeyRegister.currentState?.validate() ?? false) {
      try {
        UserCredential result =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        User dataUser = result.user!;
        phone = phoneController.text;
        uid = dataUser.uid;
        loginState = StateLogin.success;
        notifyListeners();
        _showSuccessDialog(
            context, 'Registration Successful', 'Your UID: $uid');
      } on FirebaseAuthException catch (e) {
        String errorMessage;
        if (e.code == 'weak-password') {
          errorMessage = 'The password provided is too weak.';
        } else if (e.code == 'email-already-in-use') {
          errorMessage = 'The account already exists for that email.';
        } else {
          errorMessage = 'Registration failed. Please try again.';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An unknown error occurred.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill out the form correctly.')),
      );
    }
  }

  void _showSuccessDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

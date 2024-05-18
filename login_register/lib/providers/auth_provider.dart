import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum StateLogin { initial, success, error }

class AuthProvider with ChangeNotifier {
  bool? isChecked = true;
  bool? isUsernameValid = true;
  bool? isPasswordValid = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final formKeyLogin = GlobalKey<FormState>();
  final formKeyRegister = GlobalKey<FormState>();
  var loginState = StateLogin.initial;
  var username = '';
  var uid = '';
  var messageError = '';

  void validation() {
    formKey.currentState!.validate();
    notifyListeners();
  }

  String? usernameValidation(String? value) {
    if (value!.isEmpty) {
      isUsernameValid = false;
      return 'Invalid Username';
    } else {
      isUsernameValid = true;
      return null;
    }
  }

  String? passwordValidation(String? value) {
    if (value!.isEmpty) {
      isPasswordValid = false;
      return 'Invalid Password';
    } else if (value.length < 8) {
      isPasswordValid = false;
      return 'Weak Password, Password must be at least 8 characters';
    } else {
      isPasswordValid = true;
      return null;
    }
  }

  void processRegister(BuildContext context) async {
    if (formKeyRegister.currentState!.validate()) {
      try {
        UserCredential result = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);
        User dataUser = result.user!;
        username = emailController.text;
        uid = dataUser.uid;
        loginState = StateLogin.success;
        _showSuccessDialog(context, 'Registration Successful', uid);
      } on FirebaseAuthException catch (error) {
        loginState = StateLogin.error;
        messageError = error.message!;
        showAlertError(context, messageError);
      } catch (e) {
        loginState = StateLogin.error;
        messageError = e.toString();
        showAlertError(context, messageError);
      }
    } else {
      showAlertError(context, 'Periksa kelengkapan datamu!');
    }

    notifyListeners();
  }

  void processLogin(BuildContext context) async {
    if (formKeyLogin.currentState!.validate()) {
      try {
        UserCredential result = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);
        User dataUser = result.user!;
        username = emailController.text;
        uid = dataUser.uid;
        loginState = StateLogin.success;
        _showSuccessDialog(context, 'Login Successful', uid);
      } on FirebaseAuthException catch (error) {
        loginState = StateLogin.error;
        messageError = error.message!;
        showAlertError(context, messageError);
      } catch (e) {
        loginState = StateLogin.error;
        messageError = e.toString();
        showAlertError(context, messageError);
      }
    } else {
      showAlertError(context, 'Periksa kelengkapan datamu!');
    }

    notifyListeners();
  }

  void _showSuccessDialog(BuildContext context, String title, String uid) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text('UID: $uid'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void showAlertError(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(errorMessage),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Ok'),
            ),
          ],
        );
      },
    );
  }
}

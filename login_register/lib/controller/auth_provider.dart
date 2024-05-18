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

  // Validator method for email
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Tolong isi field ini';
    }
    // Check for valid email format
    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Masukkan email yang valid';
    }
    // Additional check for minimum length (optional)
    if (value.length < 6) {
      return 'Email harus memiliki panjang minimal 6 karakter';
    }
    return null;
  }

  // Validator method for email
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Tolong isi field ini';
    }
    // Check for valid email format
    // String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    // RegExp regex = RegExp(pattern);
    // if (!regex.hasMatch(value)) {
    //   return 'Masukkan password yang valid';
    // }
    // Additional check for minimum length (optional)
    if (value.length < 6) {
      return 'Email harus memiliki panjang minimal 6 karakter';
    }
    return null;
  }

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
        emailController.clear();
        passwordController.clear();
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
          errorMessage = 'Login failed. Invalid email or password.';
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
        emailController.clear();
        passwordController.clear();
        phoneController.clear();
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
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(20, 60, 20, 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.green,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      message,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 24),
                    TextButton(
                      child: Container(
                        width: 80,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.black.withOpacity(0.4)),
                        child: Center(
                          child: Text(
                            'OK',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
              Positioned(
                top: -40,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 40,
                  child: Icon(
                    Icons.check,
                    color: Colors.green,
                    size: 50,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';

class LoginRegister extends StatefulWidget {
  const LoginRegister({super.key});

  @override
  State<LoginRegister> createState() => _LoginRegisterState();
}

class _LoginRegisterState extends State<LoginRegister> {
  bool _pageMode = false;

  void _toggleMode() {
    setState(() {
      _pageMode = !_pageMode;
    });
  }

  void _handleMode() {
    if (_pageMode) {
      // Logika untuk register
    } else {
      // Logika untuk login
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 30.0, left: 10, right: 10, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey.withOpacity(0.1)),
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back_outlined)),
                  ),
                  Center(
                      child: Image.asset("assets/images/Data.png", scale: 10)),
                  Center(
                    child: Text(
                      _pageMode ? 'Login' : 'Register',
                      style: TextStyle(
                          fontSize: 25,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  SizedBox(height: 10),
                  const Text(
                    "Email",
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: 380,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey.withOpacity(0.3)),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: "Enter your Email",
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "Password",
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: 380,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey.withOpacity(0.3)),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: "Enter your password",
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  // Hanya menampilkan field Confirm Password jika dalam mode Register
                  if (!_pageMode)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        const Text(
                          "Password",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.normal),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: 380,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.grey.withOpacity(0.3)),
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: "Enter your password",
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 20),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),

                  const SizedBox(height: 30),
                  Center(
                    child: Container(
                      width: 350,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blue.withOpacity(
                            0.7), // Warna latar belakang tetap sama untuk tombol utuh
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                if (!_pageMode) {
                                  _toggleMode(); // Toggle mode jika saat ini adalah mode login
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    bottomLeft: Radius.circular(20),
                                  ),
                                  color: _pageMode
                                      ? Colors.transparent
                                      : Colors
                                          .white, // Warna bagian kiri berubah saat mode login
                                ),
                                child: Center(
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                      color: _pageMode
                                          ? Colors.black
                                          : Colors
                                              .blue, // Warna teks berubah saat mode login
                                      fontFamily: 'Poppins',
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                if (_pageMode) {
                                  _toggleMode(); // Toggle mode jika saat ini adalah mode register
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                  ),
                                  color: !_pageMode
                                      ? Colors.transparent
                                      : Colors
                                          .white, // Warna bagian kanan berubah saat mode register
                                ),
                                child: Center(
                                  child: Text(
                                    'Register',
                                    style: TextStyle(
                                      color: !_pageMode
                                          ? Colors.black
                                          : Colors
                                              .blue, // Warna teks berubah saat mode register
                                      fontFamily: 'Poppins',
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _pageMode
                            ? "Don't have an account?"
                            : "Already have an account?",
                        style: TextStyle(fontSize: 16),
                      ),
                      GestureDetector(
                        onTap: _toggleMode,
                        child: Container(
                          width: 70,
                          height: 40,
                          child: Center(
                              child: Text(
                            _pageMode ? "Register" : "Login",
                            style: TextStyle(fontSize: 16),
                          )),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

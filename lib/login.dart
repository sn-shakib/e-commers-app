import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:full_app/sign%20up%20page.dart';
import 'package:full_app/store_page/store_page.dart';
import 'package:full_app/user.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController mailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  bool isvisible = true;

  //Code from shaidur
  //Default register page loading
  bool _loginPageLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          height: 600,
          //padding: const EdgeInsets.symmetric(horizontal: 16),
          color: Colors.black,
          child: ListView(
            children: [
              Container(
                padding: EdgeInsets.all(15),
                child: Image.asset(
                  'assets/images/login.png',
                  height: 200,
                  width: 200,
                ),
              ),
              Container(
                height: 400,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                    'assets/images/bac.png',
                  )),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      'User login',
                      style: GoogleFonts.aclonica(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrange),
                    ),
                    const SizedBox(height: 10),
                    // Container(
                    //   decoration: BoxDecoration(
                    //     color: Colors.white,
                    //     border: Border.all(color: Colors.grey),
                    //     borderRadius: BorderRadius.circular(5),
                    //   ),
                    //   margin: EdgeInsets.fromLTRB(20, 300, 20, 10),
                    //   padding: EdgeInsets.fromLTRB(10, 0, 10, 25),
                    //   child: Column(
                    //     children: const [
                    //       // TextField(
                    //       //   decoration: InputDecoration(
                    //       //     icon: Icon(Icons.mail,color: Color(0xFFFF4891),
                    //       //     ),
                    //       //     focusedBorder: OutlineInputBorder(borderSide:BorderSide(color: Color(0xFFFF4891)) ),
                    //       //     labelText:"email:",
                    //       //     labelStyle: TextStyle(color: Color(0xFFFF4891)),
                    //       //
                    //       //   ),
                    //       // ),
                    //       // TextField(
                    //       //   obscureText: true,
                    //       //   decoration: InputDecoration(
                    //       //     icon: Icon(Icons.vpn_key,color: Color(0xFFFF4891),
                    //       //     ),
                    //       //     focusedBorder: OutlineInputBorder(borderSide:BorderSide(color: Color(0xFFFF4891)) ),
                    //       //     labelText:"Password:",
                    //       //     labelStyle: TextStyle(color: Color(0xFFFF4891)),
                    //       //
                    //       //   ),
                    //       // ),
                    //     ],
                    //   ),
                    // ),
                    TextField(
                      onChanged: (value) {
                        setState(() {});
                      },
                      controller: mailcontroller,
                      decoration: InputDecoration(
                        fillColor: Colors.lightGreenAccent,
                        filled: true,
                        isDense: true,
                        hintText: 'user mail',
                        hintStyle: GoogleFonts.andada(color: Colors.black),
                        prefixIcon: const Icon(Icons.mail),
                        suffixIcon: mailcontroller.text.isEmpty
                            ? const Text('')
                            : GestureDetector(
                                onTap: () {
                                  mailcontroller.clear();
                                  setState(() {});
                                },
                                child: const Icon(Icons.close)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      obscureText: isvisible,
                      controller: passwordcontroller,
                      decoration: InputDecoration(
                        fillColor: Colors.lightGreenAccent,
                        filled: true,
                        isDense: true,
                        hintText: 'user password',
                        hintStyle: GoogleFonts.andada(color: Colors.black),
                        prefixIcon: const Icon(Icons.password),
                        suffixIcon: GestureDetector(
                            onTap: () {
                              isvisible = !isvisible;
                              setState(() {});
                            },
                            child: Icon(isvisible
                                ? Icons.visibility
                                : Icons.visibility_off)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    MaterialButton(
                      minWidth: 190,
                      height: 40,
                      shape: const StadiumBorder(),
                      color: Colors.blue,
                      onPressed: () async {
                        try {
                          _showLoading(true);
                          UserCredential userCredential = await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                            email: mailcontroller.text,
                            password: passwordcontroller.text,
                          );
                          var user = userCredential.user;
                          if (user != null) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const StorePage()));
                            user_id = user.uid;
                            print(user.uid);
                            email_id = mailcontroller.text;
                          }
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            showErrorDialog(
                                errorMsg: 'No user found for that email.');
                            print('No user found for that email.');
                          } else if (e.code == 'wrong-password') {
                            showErrorDialog(
                                errorMsg:
                                    'Wrong password provided for that user.');
                            print('Wrong password provided for that user.');
                          }
                        }
                        _showLoading(false);
                      },
                      child: Text(
                        'Login',
                        style: GoogleFonts.alef(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'Forgot password?',
                              style: GoogleFonts.andada(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ))),
                    const SizedBox(height: 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          ' Dont have any account?',
                          style: GoogleFonts.andada(color: Colors.black),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SignupPage()));
                            },
                            child: Text(
                              'Create one',
                              style: GoogleFonts.amethysta(
                                color: Colors.red,
                              ),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Visibility(
          visible: _loginPageLoading,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.black45,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      ]),
    );
  }

  showErrorDialog({required String errorMsg}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'warning'.toUpperCase(),
              style: GoogleFonts.andada(color: Colors.red),
            ),
            content: Text(errorMsg),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Ok',),
              )
            ],
          );
        });
  }

  //Show or Hide loading circle
  void _showLoading(bool doLoading) {
    setState(() {
      _loginPageLoading = doLoading;
    });
  }
}

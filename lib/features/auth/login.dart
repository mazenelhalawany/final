import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_9_final_project/features/home/mainpage.dart';
import 'package:flutter_application_9_final_project/core/widget/snakBar.dart';
import 'package:flutter_svg/svg.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();
//
  login() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      showSnackBar(context, "Done");
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainPage()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        showSnackBar(context, "No user found for that email.");
      }
    }
  }

  @override
  dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                child: Image.asset(
                  "assets/images/main_top.png",
                  width: 150,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: Image.asset(
                  "assets/images/main_bottom.png",
                  width: 100,
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.black,
                            fontFamily: "myfont"),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      SvgPicture.asset(
                        "assets/icons/login.svg",
                        height: 400,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 5),
                        decoration: BoxDecoration(
                          color: Colors.purple[100],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(30)),
                        ),
                        width: 300,
                        child: TextField(
                          controller: emailController,
                          decoration: const InputDecoration(
                              hintText: "email:",
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.person),
                              suffixIcon: Icon(Icons.visibility)),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 5),
                        decoration: BoxDecoration(
                          color: Colors.purple[100],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(30)),
                        ),
                        width: 300,
                        child: TextField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                              hintText: "Password:",
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.lock),
                              suffixIcon: Icon(Icons.visibility)),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 300,
                        child: ElevatedButton(
                          onPressed: () {
                            // Navigator.pushNamed(context, "/login");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
                            );
                          },
                          style: ButtonStyle(
                            padding: WidgetStateProperty.all(
                                const EdgeInsets.symmetric(vertical: 10)),
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.purple[400]),
                            shape: WidgetStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                          child: GestureDetector(
                            onTap: () async {
                              await login();
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

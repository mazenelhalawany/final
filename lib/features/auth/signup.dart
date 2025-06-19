import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_9_final_project/features/auth/login.dart';
import 'package:flutter_svg/svg.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  register() async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
  @override
  dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
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
                  "assets/icons/signup_top.png",
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
                        "Signup",
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.black,
                            fontFamily: "myfont"),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      SvgPicture.asset(
                        "assets/icons/signup.svg",
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
                          onPressed: () async {
                            await register();
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
                            child: const Text(
                              "Signup",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have an accout? "),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()),
                              );
                            },
                            child: const Text(
                              " Log in",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      // SizedBox(
                      //   width: 299,
                      //   child: Row(
                      //     children: [
                      //       Expanded(
                      //           child: Divider(
                      //         thickness: 0.6,
                      //         color: Colors.purple[900],
                      //       )),
                      //       Text(
                      //         "OR",
                      //         style: TextStyle(
                      //           color: Colors.purple[900],
                      //         ),
                      //       ),
                      //       Expanded(
                      //           child: Divider(
                      //         thickness: 0.6,
                      //         color: Colors.purple[900],
                      //       )),
                      //     ],
                      //   ),
                      // ),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      //   Row(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       Container(
                      //         decoration: BoxDecoration(
                      //             shape: BoxShape.circle,
                      //             border: Border.all(color: Colors.black)),
                      //         child: SvgPicture.asset(
                      //           "assets/icons/facebook.svg",
                      //           height: 40,
                      //         ),
                      //       ),
                      //       const SizedBox(width: 30,),
                      //      Container(
                      //         decoration: BoxDecoration(
                      //             shape: BoxShape.circle,
                      //             border: Border.all(color: Colors.black)),
                      //         child: SvgPicture.asset(
                      //           "assets/icons/twitter.svg",
                      //           height: 40,
                      //         ),
                      //       ),
                      //       const SizedBox(width: 30,)
                      //       ,
                      //       Container(
                      //         decoration: BoxDecoration(
                      //             shape: BoxShape.circle,
                      //             border: Border.all(color: Colors.black)),
                      //         child: SvgPicture.asset(
                      //           "assets/icons/google-plus.svg",
                      //           height: 40,
                      //         ),
                      //       ),
                      //       const SizedBox(width: 30,),
                      //     ],
                      //   )
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

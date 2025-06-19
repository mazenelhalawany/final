import 'package:flutter/material.dart';
import 'package:flutter_application_9_final_project/features/auth/login.dart';
import 'package:flutter_application_9_final_project/features/auth/signup.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Onbording extends StatelessWidget {
  const Onbording({super.key});

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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "welcome",
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                          fontFamily: "myfont"),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    SvgPicture.asset(
                      "assets/icons/chat.svg",
                      height: 400,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Navigator.pushNamed(context, "/login");
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      style: ButtonStyle(
                        padding: WidgetStateProperty.all(
                            const EdgeInsets.symmetric(
                                horizontal: 100, vertical: 10)),
                        backgroundColor:
                            WidgetStatePropertyAll(Colors.purple[400]),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                      child: const Text(
                        "Login",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Navigator.pushNamed(context, "/signup");
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignupPage()),
                        );
                      },
                      style: ButtonStyle(
                        padding: WidgetStateProperty.all(
                            const EdgeInsets.symmetric(
                                horizontal: 100, vertical: 10)),
                        backgroundColor:
                            WidgetStatePropertyAll(Colors.purple[100]),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                      child: const Text(
                        "Signup",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

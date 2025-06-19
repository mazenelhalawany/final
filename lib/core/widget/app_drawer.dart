import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_9_final_project/features/chat/view/dlivery_man_chat_screen.dart';

final user = FirebaseAuth.instance.currentUser!;

Drawer drawer(BuildContext context) {
  return Drawer(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            UserAccountsDrawerHeader(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/printer.jpg"),
                  ),
                ),
                accountName: const Text("Welcome ",
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                    )),
                accountEmail: Text(user.email!),
                currentAccountPictureSize: const Size.square(80),
                currentAccountPicture: const CircleAvatar(
                    radius: 55,
                    backgroundImage: AssetImage("assets/images/printer.jpg"))
                //        OR NetworkImage(user.photoURL!)),
                ),
            ListTile(
                title: const Text("Chat"),
                leading: const Icon(Icons.add_shopping_cart),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DliveryManChatScreen(),
                      ));
                }),
            ListTile(
                title: const Text("Profile Page"),
                leading: const Icon(Icons.person),
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => MyProfilePage(),
                  //     ));
                }),
            ListTile(
                title: const Text("About"),
                leading: const Icon(Icons.help_center),
                onTap: () {}),
            ListTile(
              title: const Text("Logout"),
              leading: const Icon(Icons.exit_to_app),
              onTap: () async {
                try {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushNamed(context, "/");
                  print(" User signed out successfully!");
                } catch (e) {
                  print(" Error signing out: $e");
                }
              },
            ),
          ],
        ),
      ],
    ),
  );
}

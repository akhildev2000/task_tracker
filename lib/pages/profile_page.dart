import 'package:flutter/material.dart';
import 'package:vaanam_task/pages/user_auth_screen.dart';
import '../services/auth_services.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, required this.user});
  final String user;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(0, 0, 0, 0.867),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              maxRadius: 120,
              backgroundImage: user == 'manager'
                  ? const AssetImage('assets/mng.jpg')
                  : const AssetImage('assets/emp.jpg'),
            ),
            const SizedBox(height: 20),
            Text(
              user.toUpperCase(),
              style: const TextStyle(color: Colors.white, fontSize: 25),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                tileColor: Colors.grey,
                shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(11)),
                trailing: const Icon(
                  Icons.login_outlined,
                  color: Colors.white,
                ),
                title: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
                onTap: () {
                  AuthService().logout();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const SignUpPage()),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

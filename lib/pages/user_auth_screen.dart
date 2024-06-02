// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:vaanam_task/pages/main_screen.dart';
import '../services/auth_services.dart';
import '../widgets/text_item.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool circular = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Sign In",
                style: TextStyle(
                  fontSize: 35,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextItem(
                          labelText: 'Username',
                          controller: _usernameController,
                          obscureText: false),
                      const SizedBox(
                        height: 15,
                      ),
                      TextItem(
                          labelText: "Password...",
                          controller: _passwordController,
                          obscureText: true),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              colorButton(),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "For Sign In use this credentials ",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "As Manager, username= manager & password = password",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                ),
              ),
              const Text(
                "As Employee, username= employee002 or employee003\n& password = password",
                style: TextStyle(color: Colors.white, fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget colorButton() {
    return InkWell(
      onTap: () async {
        if (_formKey.currentState!.validate()) {
          final user = await AuthService().login(
            _usernameController.text,
            _passwordController.text,
          );
          if (user != null) {
            // Navigate to the task list based on the user's role
            if (user.role == 'Manager') {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MainScreen(
                          user: user.username,
                        )),
              );
            } else if (user.role == 'Employee') {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MainScreen(
                          user: user.username,
                        )),
              );
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Invalid username or password'),
                duration: Duration(seconds: 2),
              ),
            );
          }
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width - 100,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(colors: [
            Color(0xfffd746c),
            Color(0xffff9068),
            Color(0xfffd746c)
          ]),
        ),
        child: Center(
          child: circular
              ? const CircularProgressIndicator()
              : const Text(
                  "Sign Up",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
        ),
      ),
    );
  }
}

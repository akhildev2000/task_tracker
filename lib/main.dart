import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vaanam_task/pages/user_auth_screen.dart';
import 'package:vaanam_task/services/main_model_provider.dart';
import 'package:vaanam_task/services/main_screen_provider.dart';
import 'package:vaanam_task/services/task_provider.dart';
import 'package:vaanam_task/services/user_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MainModel()),
        ChangeNotifierProvider(create: (context) => TaskProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => MainScreenNotifer())
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const SignUpPage()),
    );
  }
}

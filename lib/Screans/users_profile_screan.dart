import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_2/Screans/login_screan.dart';

class UserProfileScrean extends StatefulWidget {
  const UserProfileScrean({super.key});

  @override
  State<UserProfileScrean> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<UserProfileScrean> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login Success')),
      body: Column(
        children: [
          Center(child: Text("Success Login")),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => LoginScrean()),
              );
            },
            child: Text("Login with anouther Account"),
          ),
        ],
      ),
    );
  }
}

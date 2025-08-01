import 'package:flutter/material.dart';
import 'package:flutter_application_2/cubites/them_cubit/tem_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_2/Screans/login_screan.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final TextEditingController _passwordController = TextEditingController();
  String savedPassword = '';

  @override
  void initState() {
    super.initState();
    loadSavedPassword();
  }

  Future<void> loadSavedPassword() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      savedPassword = prefs.getString('password') ?? '';
    });
  }

  Future<void> savePassword() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('password', _passwordController.text);
    setState(() {
      savedPassword = _passwordController.text;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Password updated successfully')),
    );
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Settings')),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            // Dark Mode Toggle
            Card(
              child: SwitchListTile(
                title: Text('Dark Mode', style: TextStyle(fontSize: 18)),
                value: isDark,
                onChanged: (value) {
                  BlocProvider.of<ThemeCubit>(context).toggleTheme(value);
                },
              ),
            ),
            SizedBox(height: 20),

            // Change Password
            Card(
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Change Password',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(labelText: 'New Password'),
                      obscureText: true,
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: savePassword,
                      child: Text('Save Password'),
                    ),
                    SizedBox(height: 8),
                    Text('Saved Password: $savedPassword'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            // Logout Button
            ElevatedButton.icon(
              onPressed: logout,
              icon: Icon(Icons.logout),
              label: Text('Logout'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

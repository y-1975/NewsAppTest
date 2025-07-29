import 'package:flutter_application_2/Screans/forget_Screan.dart';
import 'package:flutter_application_2/Screans/register_screan.dart';
import 'package:flutter_application_2/Screans/users_profile_screan.dart';
import 'package:flutter_application_2/cubites/auth_cubit.dart';
import 'package:flutter_application_2/cubites/auth_state.dart';
import 'package:flutter_application_2/main.dart';
import 'package:flutter_application_2/models/user_model.dart';
import 'package:flutter_application_2/utils/validation_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class LoginScrean extends StatefulWidget {
  // final UserModel user;

  const LoginScrean({super.key});

  @override
  State<LoginScrean> createState() => _LoginState();
}

class _LoginState extends State<LoginScrean> {
  bool isRemmembered = false;
  Validation valid = Validation();
  final _formKey = GlobalKey<FormState>();
  String name = '';

  int id = 0;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Center(child: Text("Log in")),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    return Container(
                      padding: EdgeInsets.all(20),
                      margin: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.tealAccent,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      width: 400,
                      height: 650,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(label: Text("Email")),
                              validator: (value) {
                                valid.validatePassword(value!);
                                if (state.emails.keys.contains(value)) {
                                  return null;
                                }
                                return 'Your Email is not founded Try Create Account';
                              },
                            ),
                            SizedBox(height: 10),

                            TextFormField(
                              controller: passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                label: Text("Password"),
                              ),
                              validator: (value) {
                                valid.validatePassword(value!);
                                if (state.emails[emailController.text] ==
                                    value) {
                                  return null;
                                }
                                return 'InCorrect Password try again';
                              },
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => ForgetScrean(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "Forget Password",
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 15,
                                      decoration: TextDecoration.underline,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  '   Remmember me',
                                  style: TextStyle(
                                    fontSize: 17,

                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Checkbox(
                                  checkColor: Colors.blue,
                                  activeColor: Colors.amber,
                                  value: isRemmembered,
                                  onChanged: (valu) {
                                    isRemmembered = valu!;
                                    context.read<AuthCubit>().remmberd(
                                      isRemmembered,
                                    );
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.lightGreenAccent,
                                    ),
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        context.read<AuthCubit>().login(
                                          emailController.text,
                                          isRemmembered,
                                          passwordController.text,
                                        );
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => UserProfileScrean(),
                                          ),
                                        );
                                      }
                                    },
                                    child: Text(
                                      "Log in",
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 15,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (_) => Register()),
                                );
                              },
                              child: Column(
                                children: [
                                  Text(
                                    'Dont have Account ?',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,

                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "Creat Account",
                                    style: TextStyle(
                                      // color: Colors.black,
                                      fontSize: 17,
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

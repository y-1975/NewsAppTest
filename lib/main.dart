import 'package:flutter/material.dart';
import 'package:flutter_application_2/Screans/login_screan.dart';
import 'package:flutter_application_2/Screans/register_screan.dart';
import 'package:flutter_application_2/Screans/users_profile_screan.dart';
import 'package:flutter_application_2/cubites/auth_cubit.dart';
import 'package:flutter_application_2/cubites/auth_state.dart';
import 'package:flutter_application_2/models/user_model.dart';
import 'package:flutter_application_2/servieses/local_storage_servies.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  bool isRemembered = await LocalStorageService.loadRemembered();

  runApp(
    BlocProvider(
      create: (context) => AuthCubit(),
      child: MyApp(isRemembered: isRemembered),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isRemembered;
  const MyApp({super.key, required this.isRemembered});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: MyHomePage(
        title: 'Flutter Demo Home Page',
        isRemembered: isRemembered,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  final bool isRemembered;

  const MyHomePage({
    super.key,
    required this.title,
    required this.isRemembered,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return widget.isRemembered ? UserProfileScrean() : LoginScrean();
  }
}

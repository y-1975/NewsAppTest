import 'package:flutter/material.dart';
import 'package:flutter_application_2/Screans/display_news_screen.dart';
import 'package:flutter_application_2/Screans/login_screan.dart';
import 'package:flutter_application_2/cubites/auth_cubit/auth_cubit.dart';
import 'package:flutter_application_2/cubites/them_cubit/tem_cubit.dart';
import 'package:flutter_application_2/servieses/dio_helper.dart';
import 'package:flutter_application_2/servieses/local_storage_servies.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  bool isRemembered = await LocalStorageService.loadRemembered();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => ThemeCubit()),
      ],
      child: MyApp(isRemembered: isRemembered),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isRemembered;
  const MyApp({super.key, required this.isRemembered});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themMode) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: themMode ,
          home: MyHomePage(
            title: 'Flutter Demo Home Page',
            isRemembered: isRemembered,
          ),
        );
      },
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
    return widget.isRemembered ? DisplayNewsScreen() : LoginScreen();
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_apps/models/carts.dart';
import 'package:travel_apps/models/favorite.dart';
import 'package:travel_apps/screens/favorite.dart';
import 'package:travel_apps/screens/home.dart';
import 'package:travel_apps/register/login.dart';
import 'package:travel_apps/register/signup.dart';

List<Map<String, String>> users = [
  {'username': 'username1', 'password': 'password1'},
  {'username': 'username2', 'password': 'password2'},
  {'username': 'username3', 'password': 'password3'},
];

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Carts()),
        ChangeNotifierProvider(create: (context) => Favorite()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // ignore: use_super_parameters
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: false),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(users: users),
        '/signup': (context) => const SignupPage(),
        '/home': (context) => const Home(),
        '/favorite': (context) => const FavoriteScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

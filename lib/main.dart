import 'package:clone_instagram/screens/auth_page/sign%20up/create_user.dart';
import 'package:clone_instagram/screens/provider.dart';
import 'package:clone_instagram/screens/splash/splash_screen.dart';
import 'package:clone_instagram/shard/widgets/theme/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            return UserProvider();
          },
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(backgroundColor: darkBackground),
          scaffoldBackgroundColor: Colors.black,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        ),

        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(
                color: Colors.white,
              );
            } else if (snapshot.hasError) {
              return Scaffold(
                body: Center(
                  child: Column(
                    children: [
                      Text("${snapshot.error}"),
                      ElevatedButton(
                          onPressed: () {}, child: const Text("restart")),
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasData) {
              return SplashScreen(
                goTo: 'login',
              );
            } else if (snapshot.data == null) {
              return SplashScreen(
                goTo: 'login',
              );
            } else {
              return const Scaffold();
            }
          },
        ),
        // home: CreateUser(),
      ),
    );
  }
}

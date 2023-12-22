import 'dart:io';

import 'package:dich_vu_it/app/constant/firemessage.dart';
import 'package:dich_vu_it/app/constant/setting.dart';
//import 'package:dich_vu_it/provider/session.provider.dart';
import 'package:dich_vu_it/repository/authentication.repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'modules/login/ui/login.screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

late Size mq;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  HttpOverrides.global = MyHttpOverrides();
  await Firebase.initializeApp();
  await FireMessage.registerToken();
  FireMessage.registerFirebase();
  runApp(MyApp(FireMessage.authenticationRepository));
}

class MyApp extends StatelessWidget {
  final AuthenticationRepository authenticationRepository;
  const MyApp(this.authenticationRepository, {super.key});

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: authenticationRepository),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const LoginScreen(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/app.dart';
import 'package:firebase_core/firebase_core.dart';
import './firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black,
      statusBarColor: Colors.transparent,
    ),
  );

  runApp(const App());
}

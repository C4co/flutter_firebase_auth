import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/app.dart';
import 'package:firebase_core/firebase_core.dart';
import './firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'core/themes/basic.theme.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor: primaryColorShades.shade900,
      statusBarColor: Colors.transparent,
    ),
  );

  runApp(const App());
}

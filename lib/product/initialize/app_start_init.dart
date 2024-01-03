import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';

import 'package:flutter/material.dart';
import 'package:flutter_news_app/firebase_options.dart';
import 'package:flutter_news_app/product/initialize/app_cache.dart';
import 'package:kartal/kartal.dart';

@immutable
class AppStart {
  const AppStart._();
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await DeviceUtility.instance.initPackageInfo();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    FirebaseUIAuth.configureProviders(
      [
        EmailAuthProvider(),
        GoogleProvider(clientId: ''),
      ],
    );
    await AppCache.instance.setup();
  }
}

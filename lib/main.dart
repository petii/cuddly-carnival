import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import 'pages/event_list.dart';
import 'pages/discover.dart';
import 'pages/loginsplash.dart';
import 'routes.dart';

Future<void> main() async {
  runApp(const CucaApp());
}

class CucaApp extends StatefulWidget {
  const CucaApp({Key? key}) : super(key: key);

  Future<AccessToken?> getAccesToken() async {
    final LoginResult result = await FacebookAuth.instance.login(
      permissions: ['public_profile', 'user_events'],
    );
    return result.accessToken;
  }

  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<CucaApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cuddly Carnival',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        // colorScheme: const ColorScheme.light(),
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('hu'),
        Locale('de'),
        Locale('fr')
      ],
      home: I18n(
        child: FutureBuilder(
            future: widget.getAccesToken(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                log(snapshot.toString());
                return const LoginSplash();
              }
              log(snapshot.data.toString());
              if (snapshot.data == null) {
                return const LoginSplash();
              }
              AccessToken token = snapshot.data!;
              return EventList(accessToken: token);
            }),
      ),
      routes: {
        ROUTE.Login: (BuildContext context) => const LoginSplash(),
        // ROUTE.Events: (BuildContext context) => EventList(),
        ROUTE.Discover: (BuildContext context) => DiscoverPage(),
      },
    );
  }
}

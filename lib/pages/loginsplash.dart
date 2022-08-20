import 'dart:developer';

import 'package:cuddly_carnival/routes.dart';
import 'package:flutter/material.dart';

class LoginSplash extends StatelessWidget {
  const LoginSplash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          TextButton(onPressed: () { log('facebook login'); }, child: const Text('Log in with facebook')),
          TextButton(onPressed: () { Navigator.pushReplacementNamed(context, ROUTE.Events); }, child: const Text('Skip')),
        ],
    );
  }
}

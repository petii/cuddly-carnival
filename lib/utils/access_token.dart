import 'dart:convert';

import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<AccessToken?> getAccessToken() async {
  final preferences = await SharedPreferences.getInstance();
  String? maybeToken = preferences.getString('accesstoken');
  if (maybeToken != null) {
    // TODO: mother fucker... toJson dumps iso8601 dates,
    //                        fromJson eats time since epoch
    Map<String, dynamic> tokenJson = jsonDecode(maybeToken);
    tokenJson['expires'] =
        DateTime.parse(tokenJson['expires']).millisecondsSinceEpoch;
    tokenJson['lastRefresh'] =
        DateTime.parse(tokenJson['lastRefresh']).millisecondsSinceEpoch;
    // TODO: ask for refreshed access token if expired
    return AccessToken.fromJson(tokenJson);
  }
  final LoginResult result = await FacebookAuth.instance.login(
    permissions: ['public_profile', 'user_events'],
  );
  if (result.status == LoginStatus.success) {
    final token = result.accessToken!;
    final tokenJson = jsonEncode(token.toJson());
    preferences.setString('accesstoken', tokenJson);
  }
  return result.accessToken;
}
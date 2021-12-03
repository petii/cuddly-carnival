import 'dart:convert';
import 'dart:developer';

import 'package:cuddly_carnival/model/response.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:http/http.dart' as http;

class ApiConstants {
  static const String authority = 'graph.facebook.com';
  static const String basePath = '/v11.0';
  static final Uri baseUri = Uri.https('graph.facebook.com', '/v11.0');
}

class EventRequests {
  const EventRequests(this.accessToken);

  Future<EventResponseModel> get({List<String>? fields, int? limit}) async {
    String path = '${ApiConstants.basePath}/me/events';

    var query = <String, String>{
      'access_token': accessToken.token,
    };
    if (fields != null) {
      query['fields'] = fields.join(',');
    }
    if (limit != null) {
      query['limit'] = limit.toString();
    }

    Uri requestUri = Uri.https(ApiConstants.authority, path, query);
    log(requestUri.toString());

    var rawResponse = await _sendRequest(requestUri);
    var json = jsonDecode(rawResponse.body);
    log('${rawResponse.statusCode}: ${rawResponse.reasonPhrase}');
    log('${json.toString().substring(0, rawResponse.statusCode)}...');

    var response = EventResponseModel.fromJson(json);
    return response;
  }

  Future<EventResponseModel> getNext(Uri next) async {
    // log(next.toString());
    var rawResponse = await _sendRequest(next);
    var json = jsonDecode(rawResponse.body);
    var response = EventResponseModel.fromJson(json);
    return response;
  }

  Future<http.Response> _sendRequest(Uri request) async {
    var rawResponse = await http.get(request);
    if (rawResponse.statusCode != 200) {
      throw Error();
    }
    return rawResponse;
  }

  final AccessToken accessToken;
}

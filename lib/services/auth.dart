import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:myshop_mobx/models/http_exception.dart';

class AuthService {
  Future<Map<String, dynamic>> authenticate(
      String email, String password, String urlSegment) async {
    final url =
        'https://www.googleapis.com/identitytoolkit/v3/relyingparty/$urlSegment?key=AIzaSyDCpvMYPAiXkINtBmz8ZuRM-HCfCiR3bbw';

    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      return responseData;
    } catch (error) {
      throw error;
    }
  }
}

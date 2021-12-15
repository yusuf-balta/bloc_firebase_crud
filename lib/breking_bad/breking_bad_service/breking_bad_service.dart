import 'package:dio/dio.dart';

class BrekingBadService {
  Future<Response?> getHttp() async {
    try {
      var response =
          await Dio().get('https://breakingbadapi.com/api/characters');

      return response;
    } catch (e) {}
  }
}

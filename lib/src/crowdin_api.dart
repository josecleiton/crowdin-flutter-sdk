import 'dart:convert';

import 'package:http/http.dart' as http;

class CrowdinApi {
  Future<Map<String, dynamic>?> loadTranslations({
    required String distributionHash,
    String? path,
  }) async {
    try {
      var response = await http.get(
        Uri.parse('https://distributions.crowdin.net/$distributionHash$path'),
      );
      Map<String, dynamic> responseDecoded =
          jsonDecode(utf8.decode(response.bodyBytes));
      return responseDecoded;
    } catch (_) {
      return null;
    }
  }

  Future<Map<String, dynamic>?> getManifest({
    required String distributionHash,
  }) async {
    try {
      var response = await http.get(
        Uri.parse(
            'https://distributions.crowdin.net/$distributionHash/manifest.json'),
      );
      Map<String, dynamic> responseDecoded =
          jsonDecode(utf8.decode(response.bodyBytes));
      return responseDecoded;
    } catch (_) {
      return null;
    }
  }

  Future<Map<String, dynamic>?> getMapping({
    required String distributionHash,
    required String mappingFilePath,
  }) async {
    try {
      var response = await http.get(Uri.parse(
          'https://distributions.crowdin.net/$distributionHash$mappingFilePath'));
      Map<String, dynamic> responseDecoded =
          jsonDecode(utf8.decode(response.bodyBytes));
      return responseDecoded;
    } catch (ex) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> getMetadata({
    required String accessToken,
    required String distributionHash,
    String? organizationName,
  }) async {
    try {
      String organizationDomain =
          organizationName != null ? '$organizationName.' : '';
      var response = await http.get(
          Uri.parse(
              'https://${organizationDomain}api.crowdin.com/api/v2/distributions/metadata?hash=$distributionHash'),
          headers: {'Authorization': 'Bearer $accessToken'});
      Map<String, dynamic> responseDecoded =
          jsonDecode(utf8.decode(response.bodyBytes));
      return responseDecoded;
    } catch (ex) {
      return null;
    }
  }
}

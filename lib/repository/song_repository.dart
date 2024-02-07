import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shazam_clone/constants.dart';
import 'package:shazam_clone/models/song_model.dart';

class SongRepository {
  /// HTTP Client
  static http.Client client = http.Client();

  /// Sends OpenAPI request.
  static Future<SpotifySongModel?> getTrack({required String trackId}) async {
    var url = Uri.parse("https://api.spotify.com/v1/tracks/$trackId");

    try {
      var response = await http.get(url, headers: {
        "Authorization": 'Bearer $token',
      });
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        SpotifySongModel result = SpotifySongModel.fromJson(data);
        return result;
      } else {
        return null;
      }
    } catch (_) {
      return null;
    }
  }
}

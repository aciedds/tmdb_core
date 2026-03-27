import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:tmdb_core/utils/api_constants.dart';

class ImageUtils {
  ImageUtils._();

  static Future<String?> imageToBase64(String imageUrl) async {
    final response = await http.get(
      Uri.parse("${ApiConstants.imageBaseUrl}$imageUrl"),
    );
    if (response.statusCode == 200) {
      Uint8List bytes = response.bodyBytes;
      String base64Image = base64Encode(bytes);
      return base64Image;
    }
    return null;
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myapp/models/album.dart';
import 'package:myapp/models/photo.dart';

class ApiService {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<List<Album>> fetchAlbums() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/albums'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        return jsonResponse.map((album) => Album.fromJson(album)).toList();
      } else {
        throw Exception('Failed to load albums');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  Future<List<Photo>> fetchPhotos(int albumId) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/photos?albumId=$albumId'),
      );
      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        return jsonResponse.map((photo) => Photo.fromJson(photo)).toList();
      } else {
        throw Exception('Failed to load photos');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/album.dart';

class ApiService {
  final String baseUrl = 'https://jsonplaceholder.typicode.com';
  final http.Client _client;

  ApiService({http.Client? client}) : _client = client ?? http.Client();

  Future<List<Album>> getAlbums() async {
    try {
      final response = await _client.get(Uri.parse('$baseUrl/albums'));
      if (response.statusCode == 200) {
        final List<dynamic> albumsJson = json.decode(response.body);
        final List<Album> albums = albumsJson
            .map((json) => Album.fromJson(json))
            .toList();

        // Fetch photos for each album
        final photosResponse = await _client.get(Uri.parse('$baseUrl/photos'));
        if (photosResponse.statusCode == 200) {
          final List<dynamic> photosJson = json.decode(photosResponse.body);
          final Map<int, Map<String, dynamic>> photosMap = {};

          for (var photo in photosJson) {
            final albumId = photo['albumId'] as int;
            if (!photosMap.containsKey(albumId)) {
              photosMap[albumId] = photo;
            }
          }

          // Update albums with photo information
          for (var album in albums) {
            if (photosMap.containsKey(album.id)) {
              final photo = photosMap[album.id]!;
              album = Album(
                id: album.id,
                userId: album.userId,
                title: album.title,
                thumbnailUrl: photo['thumbnailUrl'] as String,
                url: photo['url'] as String,
              );
            }
          }
        }

        return albums;
      } else {
        throw Exception('Failed to load albums');
      }
    } catch (e) {
      throw Exception('Error fetching albums: $e');
    }
  }

  Future<Album> getAlbumDetails(int albumId) async {
    try {
      final response = await _client.get(Uri.parse('$baseUrl/albums/$albumId'));
      if (response.statusCode == 200) {
        final albumJson = json.decode(response.body);
        final album = Album.fromJson(albumJson);

        // Fetch photo for the album
        final photosResponse = await _client.get(
          Uri.parse('$baseUrl/photos?albumId=$albumId'),
        );
        if (photosResponse.statusCode == 200) {
          final List<dynamic> photosJson = json.decode(photosResponse.body);
          if (photosJson.isNotEmpty) {
            final photo = photosJson.first;
            return Album(
              id: album.id,
              userId: album.userId,
              title: album.title,
              thumbnailUrl: photo['thumbnailUrl'] as String,
              url: photo['url'] as String,
            );
          }
        }

        return album;
      } else {
        throw Exception('Failed to load album details');
      }
    } catch (e) {
      throw Exception('Error fetching album details: $e');
    }
  }
}

sealed class AlbumEvent {}

class FetchAlbums extends AlbumEvent {}

class FetchPhotos extends AlbumEvent {
  final int albumId;

  FetchPhotos({required this.albumId});
}

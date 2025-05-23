sealed class AlbumState {}

class AlbumInitial extends AlbumState {}

class AlbumLoading extends AlbumState {}

class AlbumLoaded extends AlbumState {
  final List<Album> albums;
  AlbumLoaded({required this.albums});
}

class PhotosLoaded extends AlbumState {
  final List<Photo> photos;
  PhotosLoaded({required this.photos});
}

class AlbumError extends AlbumState {
  final String message;
  AlbumError({required this.message});
}
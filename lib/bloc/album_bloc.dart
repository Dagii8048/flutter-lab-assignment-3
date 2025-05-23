import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/bloc/album_event.dart';
import 'package:myapp/bloc/album_state.dart';
import 'package:myapp/models/album.dart';
import 'package:myapp/models/photo.dart';
import 'package:myapp/services/api_service.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  final ApiService _apiService;

  AlbumBloc(this._apiService) : super(AlbumInitial()) {
    on<FetchAlbums>(_onFetchAlbums);
    on<FetchPhotos>(_onFetchPhotos);
  }

  Future<void> _onFetchAlbums(
    FetchAlbums event,
    Emitter<AlbumState> emit,
  ) async {
    emit(AlbumLoading());
    try {
      final albums = await _apiService.fetchAlbums();
      emit(AlbumLoaded(albums: albums));
    } catch (e) {
      emit(AlbumError(message: e.toString()));
    }
  }

  Future<void> _onFetchPhotos(
    FetchPhotos event,
    Emitter<AlbumState> emit,
  ) async {
    emit(AlbumLoading()); // Or a specific PhotoLoading state if preferred
    try {
      final photos = await _apiService.fetchPhotos(event.albumId);
      emit(PhotosLoaded(photos: photos));
    } catch (e) {
      emit(AlbumError(message: e.toString()));
    }
  }
}
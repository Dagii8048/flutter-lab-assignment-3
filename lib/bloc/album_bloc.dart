import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/album.dart';
import '../services/api_service.dart';

// Events
abstract class AlbumEvent extends Equatable {
  const AlbumEvent();

  @override
  List<Object> get props => [];
}

class LoadAlbums extends AlbumEvent {}

class LoadAlbumDetails extends AlbumEvent {
  final int albumId;

  const LoadAlbumDetails(this.albumId);

  @override
  List<Object> get props => [albumId];
}

// States
abstract class AlbumState extends Equatable {
  const AlbumState();

  @override
  List<Object> get props => [];
}

class AlbumInitial extends AlbumState {}

class AlbumLoading extends AlbumState {}

class AlbumsLoaded extends AlbumState {
  final List<Album> albums;

  const AlbumsLoaded(this.albums);

  @override
  List<Object> get props => [albums];
}

class AlbumDetailsLoaded extends AlbumState {
  final Album album;

  const AlbumDetailsLoaded(this.album);

  @override
  List<Object> get props => [album];
}

class AlbumError extends AlbumState {
  final String message;

  const AlbumError(this.message);

  @override
  List<Object> get props => [message];
}

// Bloc
class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  final ApiService _apiService;

  AlbumBloc(this._apiService) : super(AlbumInitial()) {
    on<LoadAlbums>(_onLoadAlbums);
    on<LoadAlbumDetails>(_onLoadAlbumDetails);
  }

  Future<void> _onLoadAlbums(LoadAlbums event, Emitter<AlbumState> emit) async {
    emit(AlbumLoading());
    try {
      final albums = await _apiService.getAlbums();
      emit(AlbumsLoaded(albums));
    } catch (e) {
      emit(AlbumError(e.toString()));
    }
  }

  Future<void> _onLoadAlbumDetails(
    LoadAlbumDetails event,
    Emitter<AlbumState> emit,
  ) async {
    print('Loading album details for ID: ${event.albumId}');
    emit(AlbumLoading());
    try {
      final album = await _apiService.getAlbumDetails(event.albumId);
      print('Album details loaded: $album');
      emit(AlbumDetailsLoaded(album));
    } catch (e) {
      print('Error loading album details: $e');
      emit(AlbumError(e.toString()));
    }
  }
}

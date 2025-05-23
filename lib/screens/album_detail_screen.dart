import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/bloc/album_bloc.dart';
import 'package:myapp/bloc/album_event.dart';
import 'package:myapp/bloc/album_state.dart';

class AlbumDetailScreen extends StatelessWidget {
  final int albumId;

  const AlbumDetailScreen({Key? key, required this.albumId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Album Photos'),
      ),
      body: BlocProvider(
        create: (context) =>
            AlbumBloc()..add(FetchPhotos(albumId: albumId)),
        child: BlocBuilder<AlbumBloc, AlbumState>(
          builder: (context, state) {
            if (state is AlbumLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AlbumError) {
              return Center(child: Text('Error: ${state.message}'));
            } else if (state is PhotosLoaded) {
              return GridView.builder(
                padding: const EdgeInsets.all(8.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: state.photos.length,
                itemBuilder: (context, index) {
                  final photo = state.photos[index];
                  return Image.network(
                    photo.thumbnailUrl,
                    fit: BoxFit.cover,
                  );
                },
              );
            }
            return const Center(child: Text('Select an album'));
          },
        ),
      ),
    );
  }
}
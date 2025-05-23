import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/album_bloc.dart';
import '../bloc/album_event.dart';
import '../bloc/album_state.dart';

class AlbumListScreen extends StatelessWidget {
  const AlbumListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Albums'),
      ),
      body: BlocBuilder<AlbumBloc, AlbumState>(
        builder: (context, state) {
          if (state is AlbumLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AlbumError) {
            return Center(child: Text('Error: ${state.message}'));
          } else if (state is AlbumLoaded) {
            return ListView.builder(
              itemCount: state.albums.length,
              itemBuilder: (context, index) {
                final album = state.albums[index];
                return ListTile(
                  title: Text(album.title),
                  onTap: () {
                    context.go('/albumDetail/${album.id}');
                  },
                );
              },
            );
          }
          return const Center(child: Text('Press the button to load albums'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<AlbumBloc>().add(FetchAlbums());
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
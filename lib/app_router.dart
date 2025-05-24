import 'package:go_router/go_router.dart';
import 'models/album.dart';
import 'screens/about_screen.dart';
import 'screens/album_detail_screen.dart';
import 'screens/album_list_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const AlbumListScreen()),
    GoRoute(
      path: '/album-details',
      builder: (context, state) {
        final album = state.extra as Album;
        return AlbumDetailScreen(album: album);
      },
    ),
    GoRoute(path: '/about', builder: (context, state) => const AboutScreen()),
  ],
);

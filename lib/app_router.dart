import 'package:go_router/go_router.dart';
import 'screens/about_screen.dart';
import 'screens/album_detail_screen.dart';
import 'screens/album_list_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const AlbumListScreen()),
    GoRoute(
      path: '/album/:id',
      builder: (context, state) {
        final albumId = int.parse(state.pathParameters['id']!);
        return AlbumDetailScreen(albumId: albumId);
      },
    ),
    GoRoute(path: '/about', builder: (context, state) => const AboutScreen()),
  ],
);

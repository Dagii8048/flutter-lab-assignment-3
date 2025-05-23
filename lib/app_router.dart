import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:your_app_name/screens/album_list_screen.dart';
import 'package:your_app_name/screens/album_detail_screen.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const AlbumListScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'albumDetail/:albumId',
          builder: (BuildContext context, GoRouterState state) {
            final albumId = int.parse(state.pathParameters['albumId']!);
            return AlbumDetailScreen(albumId: albumId);
          },
        ),
      ],
    ),
  ],
);
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/auth/auth_screen.dart';
import '../features/home/home_screen.dart';
import '../features/chat/chat_screen.dart';
import '../features/ritual_detail/ritual_detail_screen.dart';
import '../features/checklist/checklist_screen.dart';
import '../features/stats/stats_screen.dart';
// import '../services/supabase_service.dart'; // Temporarily commented until Supabase setup

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/home', // Start with home for now
    redirect: (context, state) {
      // Temporarily disable auth redirect until Supabase is set up
      // TODO: Uncomment after Supabase setup
      // final isAuthenticated = SupabaseService.instance.currentUser != null;
      // final isAuthRoute = state.matchedLocation == '/auth';

      // if (!isAuthenticated && !isAuthRoute) {
      //   return '/auth';
      // }
      // if (isAuthenticated && isAuthRoute) {
      //   return '/home';
      // }
      return null;
    },
    routes: [
      GoRoute(
        path: '/auth',
        builder: (context, state) => const AuthScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/chat',
        builder: (context, state) => const ChatScreen(),
      ),
      GoRoute(
        path: '/ritual/:id',
        builder: (context, state) => RitualDetailScreen(
          ritualId: state.pathParameters['id']!,
        ),
      ),
      GoRoute(
        path: '/checklist/:runId',
        builder: (context, state) => ChecklistScreen(
          runId: state.pathParameters['runId']!,
        ),
      ),
      GoRoute(
        path: '/stats',
        builder: (context, state) => const StatsScreen(),
      ),
    ],
  );
});
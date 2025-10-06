import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/auth/auth_screen.dart';
import '../features/home/home_screen.dart';
import '../features/chat/chat_screen.dart';
import '../features/ritual_detail/ritual_detail_screen.dart';
import '../features/checklist/checklist_screen.dart';
import '../features/stats/stats_screen.dart';
import '../pages/chat_page.dart';
import '../services/supabase_service.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/auth', // Start with auth page
    redirect: (context, state) {
      try {
        final isAuthenticated = SupabaseService.instance.currentUser != null;
        final isAuthRoute = state.matchedLocation == '/auth';

        if (!isAuthenticated && !isAuthRoute) {
          return '/auth';
        }
        if (isAuthenticated && isAuthRoute) {
          return '/home';
        }
      } catch (e) {
        // Supabase henüz başlatılmamışsa auth sayfasına yönlendir
        print('Auth check failed: $e');
        if (state.matchedLocation != '/auth') {
          return '/auth';
        }
      }
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
        path: '/llm-chat',
        builder: (context, state) => const ChatPage(),
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
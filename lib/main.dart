import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'routes/app_router.dart';
// import 'services/supabase_service.dart'; // Temporarily commented until Supabase setup

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Supabase - commented out for now until we set up the credentials
  // TODO: Uncomment after Supabase setup
  // await SupabaseService.initialize(
  //   url: 'YOUR_SUPABASE_URL',
  //   anonKey: 'YOUR_SUPABASE_ANON_KEY',
  // );

  runApp(const ProviderScope(child: RitualsApp()));
}

class RitualsApp extends ConsumerWidget {
  const RitualsApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    
    return MaterialApp.router(
      title: 'Personalized Daily Rituals',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}

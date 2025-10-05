import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'services/supabase_service.dart'; // Make sure this returns SupabaseClient

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SupabaseService.initialize(
    url: 'https://cmctelapcctnhfgfpuqk.supabase.co',
    anonKey: 'sb_publishable_m7V9FsYEvptSb_HN7ce7QQ_6GKPgEYs',
  );

  runApp(const ProviderScope(child: RitualsApp()));
}

class RitualsApp extends ConsumerWidget {
  const RitualsApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Supabase Test')),
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              try {
                final data = await SupabaseService.instance.client
                    .from('users')
                    .select()
                    .limit(1)
                    .maybeSingle();

                if (data == null) {
                  print('No data found or Supabase connection failed.');
                } else {
                  print('Supabase connection success! Data: $data');
                }
              } catch (e) {
                print('Error connecting to Supabase: $e');
              }
            },
            child: const Text('Test Supabase Connection'),
          ),
        ),
      ),
    );
  }
}

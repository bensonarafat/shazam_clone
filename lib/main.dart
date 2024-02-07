import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shazam_clone/app.dart';
import 'package:shazam_clone/providers/song_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shazam Clone',
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => SongProvider()),
        ],
        child: Consumer<SongProvider>(
          builder: (context, model, child) {
            return const App();
          },
        ),
      ),
    );
  }
}

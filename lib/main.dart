import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Provider/pixaBay_provider.dart';
import 'View/pixaBay_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SearchProvider(),
        ),
      ],
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const SearchScreen(),
        },
      ),
    );
  }
}

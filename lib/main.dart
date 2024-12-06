import 'package:flutter/material.dart';
import 'src/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'src/providers/client_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (context) => ClientProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Prestamista App',
      home: HomeScreen(),
    );
  }
}

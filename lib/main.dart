import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/scorecard_provider.dart';
import 'screens/scorecard_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ScorecardProvider(),
      child: MaterialApp(
        title: 'Clean Train Station Scorecard',
        theme: ThemeData(
          primaryColor: Colors.indigo[900],
          primarySwatch: Colors.blue,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),
        ),
        home: ScorecardScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
